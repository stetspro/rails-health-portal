class PatientsController < ApplicationController
  before_action :authenticate_patient!
  before_action :restrict_patient!, only: [:edit, :update, :destroy]

  def dashboard
    @patient = current_patient
    @appointments = current_patient.appointments.order(appointment_date: :desc, appointment_time: :desc).limit(5)
    @patient_medications = current_patient.patient_medications.joins(:medication).order('expiration_date DESC, medications.brand_name ASC').limit(5)
    @diagnoses = @patient.patient_diagnoses.joins(:diagnosis)
      .select('DISTINCT ON(patient_diagnoses.diagnosis_id) patient_diagnoses.*, diagnoses.name, diagnoses.is_chronic AS is_chronic')
      .order('patient_diagnoses.diagnosis_id, is_chronic DESC, patient_diagnoses.created_at DESC')
      .limit(5)
  end         

  private

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :email, :date_of_birth, :address, :password, :password_confirmation)
  end
end
