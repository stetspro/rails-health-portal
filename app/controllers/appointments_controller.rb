class AppointmentsController < ApplicationController
  before_action :logged_in_patient
  before_action :set_patient, only: [:new, :create]

  def index
    @appointments = current_patient.appointments
  end

  def new 
    @appointment = @patient.appointments.new
  end

  def create  
    @appointment = @patient.appointments.new(appointment_params)
    if @appointment.save
      flash[:success] = "Appointment was successfully created."
      redirect_to dashboard_path
    else
      flash.now[:error] = "An error occurred while creating the appointment."
      render :new
    end
  end

  private

  def logged_in_patient
    unless current_patient.present?
      flash[:danger] = "You need to log in to view appointments"
      redirect_to patients_sessions_path
    end
  end

  def set_patient  
    @patient = current_patient
  end

  def appointment_params  
    params.require(:appointment).permit(:appointment_date, :appointment_time, :doctor_id, :patient_id)
  end
end
