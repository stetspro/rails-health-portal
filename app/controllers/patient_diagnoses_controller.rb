class PatientDiagnosesController < ApplicationController

  def new
    @appointment = Appointment.find(params[:appointment_id])
    @patient = Patient.find(params[:patient_id])
    @patient_diagnosis = PatientDiagnosis.new
    @doctor = @appointment[:doctor_id]
  end
  
  def create
    @patient = Patient.find(params[:patient_id])
    @patient_diagnosis = @patient.patient_diagnoses.new(patient_diagnosis_params)
    if @patient_diagnosis.save
      session[:openai_result] = check_and_send_to_openai(@patient_diagnosis)
      if session[:openai_result]
        redirect_to scheduler_patient_diagnosis_path(@patient_diagnosis)
      else
        redirect_to daily_patients_doctor_path(session[:doctor_id]), notice: 'Patient diagnosis was successfully created.'
      end
    else
      render :new
    end
  end
  
  
# display the suggested appointment date to the doctor and uses the OpenAI result stored in the session to determine this suggested date
def scheduler
  @ai_scheduler = AiScheduler.new
  @patient_diagnosis = PatientDiagnosis.find(params[:id])
  @patient = @patient_diagnosis.patient
  # Parse the suggested date from the OpenAI result stored in the session
  @suggested_date = parse_date_from_openai(session[:openai_result])
  
  # Clear the OpenAI result from the session now that we've used it
  session.delete(:openai_result)
end

# create a new AiScheduler record with the confirmed appointment date
def confirm_schedule
  @patient_diagnosis = PatientDiagnosis.find(params[:id])
  @patient = @patient_diagnosis.patient
  # The date is taken from the form submission (params[:ai_scheduler][:date])
  AiScheduler.create(
    patient: @patient,
    date: params[:ai_scheduler][:date],
    patient_diagnosis: @patient_diagnosis,
    has_taken_appointment: false
  )
  redirect_to daily_patients_doctor_path(session[:doctor_id])
end

  
  
  
  
  
  private
  # This function extracts the date from OpenAI's output.
  def parse_date_from_openai(openai_result)
    # It assumes the date is in 'yyyy-mm-dd' format and is the last word in the output.
    date_str = openai_result["choices"].first["message"]["content"]
    Date.parse(date_str)
  end

  def check_and_send_to_openai(patient_diagnosis)
    diagnosis = Diagnosis.find(patient_diagnosis.diagnosis_id)
    if diagnosis.is_chronic
      OpenaiService.send_diagnosis(patient_diagnosis)
    end
  end

  def set_appointment
    @appointment = Appointment.find(params[:appointment_id])
  end
  
  def patient_diagnosis_params
    params.require(:patient_diagnosis).permit(:diagnosis_id, :complaint,:patient_id)
  end
end