class AppointmentsController < ApplicationController
  before_action :logged_in_patient
  before_action :set_patient, only: [:new, :create, :choose_time]

  def index
    @appointments = current_patient.appointments
  end

  def new
    @patient = current_patient
    @appointment = Appointment.new
    @doctors = Doctor.all
    @all_times = (9..12).to_a + (14..20).to_a # all times from 9 to 20, excluding 13
  end
  

  def create
    @patient = current_patient
    @doctor = Doctor.find(params[:appointment][:doctor_id])
    if params[:appointment][:appointment_date].present?
      # Store the appointment_date in the session
      session[:appointment_date] = params[:appointment][:appointment_date]
      redirect_to choose_time_patient_appointments_path(patient_id: @patient.id, doctor_id: @doctor.id)
    else
      @doctors = Doctor.all
      flash.now[:error] = "Please choose a date for your appointment."
      render :new
    end
  end
  

  

  def choose_time
    # Fetch the doctor using the ID from params
    @doctor = Doctor.find(params[:doctor_id])
    
    # Fetch the patient using the ID from params
    @patient = current_patient
    
    # Build an appointment for the patient and doctor
    @appointment = @patient.appointments.build(doctor: @doctor)
    
    # Fetch the date from session and convert it to a date object
    @appointment_date = Date.parse(session[:appointment_date])
    
    # Define the full range of possible appointment times
    @all_times = (9..12).to_a + (14..20).to_a
    
    # Fetch the times when the doctor already has appointments on the chosen date
    existing_appointment_times = @doctor.appointments.where(appointment_date: @appointment_date).pluck(:appointment_time).map { |time| time.hour }
    # Filter out the times when the doctor already has appointments
    @available_times = @all_times - existing_appointment_times
  end
  
  def finalize
    @patient = current_patient
    @appointment = @patient.appointments.new(appointment_params)
    @appointment.patient_id = @patient.id
    Rails.logger.info @appointment
    if @appointment.save!
      # Remove the appointment_date from the session
      session.delete(:appointment_date)
      flash[:success] = "Appointment was successfully created."
      redirect_to dashboard_path
    else
      flash.now[:error] = "An error occurred while creating the appointment."
      # Fetch the doctor using the ID from params
    @doctor = Doctor.find(params[:appointment][:doctor_id])
    
    # Fetch the patient using the ID from params
    @patient = current_patient
    
    # Build an appointment for the patient and doctor
    @appointment = @patient.appointments.build(doctor: @doctor)
    
    # Fetch the date from session and convert it to a date object
    @appointment_date = Date.parse(session[:appointment_date])
    
    # Define the full range of possible appointment times
    @all_times = (9..12).to_a + (14..20).to_a
    
    # Fetch the times when the doctor already has appointments on the chosen date
    existing_appointment_times = @doctor.appointments.where(appointment_date: @appointment_date).pluck(:appointment_time).map { |time| time.hour }
    # Filter out the times when the doctor already has appointments
    @available_times = @all_times - existing_appointment_times
      render :choose_time
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
