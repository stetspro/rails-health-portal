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
      redirect_to daily_patients_doctor_path(session[:doctor_id]), notice: 'Diagnosis was successfully created.'
    else
      render :new
    end
  end
  

  private

  def set_appointment
    @appointment = Appointment.find(params[:appointment_id])
  end
  
  def patient_diagnosis_params
    params.require(:patient_diagnosis).permit(:diagnosis_id, :complaint,:patient_id)
  end
end
