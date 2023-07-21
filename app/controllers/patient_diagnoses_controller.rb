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
      result = check_and_send_to_openai(@patient_diagnosis)
      flash[:openai_suggested_date] = parse_date_from_openai(result)
      redirect_to daily_patients_doctor_path(session[:doctor_id]), notice: 'Patient diagnosis was successfully created.'
    else
      render :new
    end
  end
  
  
  private
  def parse_date_from_openai(openai_result)
    # This function extracts the date from OpenAI's output.
    # It assumes the date is in 'yyyy-mm-dd' format and is the last word in the output.
    # You might need to adjust this depending on the exact output from OpenAI.
    openai_result["choices"].first["message"]["content"]
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