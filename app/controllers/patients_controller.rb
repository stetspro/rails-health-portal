class PatientsController < ApplicationController
  before_action :authenticate_patient!
  before_action :restrict_patient!, only: [:edit, :update, :destroy]

  def dashboard
    @patient = current_patient
    @appointments = current_patient.appointments.order(appointment_date: :desc, appointment_time: :desc).limit(5)
  end

  private
   def patient_params
    params.require(:patient).permit(:first_name, :last_name, :email, :date_of_birth, :address, :password, :password_confirmation)
  end
end
