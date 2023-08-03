class AppointmentsController < ApplicationController
   # Ensure the patient is logged in for all actions in this controller
  before_action :logged_in_patient

  # Prepare for creating a new appointment
  def new
    @patient = current_patient
    # Build a new blank appointment for the form
    @appointment = Appointment.new
    @doctors = Doctor.all
    # Retrieve the latest suggested appointment from the aischeduler table where "has_taken_appointment" is false
    @suggested_appointment = @patient.ai_schedulers.where(has_taken_appointment: false).order(created_at: :desc).first
    if @suggested_appointment
      @suggested_date = @suggested_appointment.date
      @doctor = @suggested_appointment.doctor
      # Define the range of possible appointment times, from 9 to 20, excluding 13
      @all_times = (9..12).to_a + (14..20).to_a
      # Find when the doctor already has appointments on the suggested date
      existing_appointment_times = @doctor.appointments.where(appointment_date: @suggested_date).pluck(:appointment_time).map { |time| time.hour }
      # Determine the times when the doctor is available
      @available_times = @all_times - existing_appointment_times
    end
  end
  
  
  
   # Process the form submission for creating a new appointment
   def create
    @patient = current_patient
    @doctor = Doctor.find(params[:appointment][:doctor_id])
    @suggested_appointment = @patient.ai_schedulers.order(created_at: :desc).first
    # Check if a date was chosen for the appointment
    if params[:appointment][:appointment_date].present?
      # If a date was chosen, store it in the session
      session[:appointment_date] = params[:appointment][:appointment_date]
      # Redirect to the time selection page
      redirect_to choose_time_patient_appointments_path(patient_id: @patient.id, doctor_id: @doctor.id)
    else
      # If no date was chosen, display an error
      @doctors = Doctor.all
      flash.now[:error] = "Please choose a date for your appointment."
      render :new
    end
  end

   # Prepare to select a time for the appointment
  def choose_time
      # Calls the prepare_appointment method to set up necessary variables for appointment creation
    prepare_appointment
  end
  
   # Process the form submission for finalizing an appointment
   def finalize
    # Fetch the current logged-in patient
    @patient = current_patient
    # Build a new appointment instance using parameters from the form
    @appointment = @patient.appointments.new(appointment_params)
    @appointment.patient_id = @patient.id
    # Fetch the latest AiScheduler instance for the patient
    suggested_appointment = @patient.ai_schedulers.order(created_at: :desc).first
    # Attempt to save the appointment
    if @appointment.save!
      # If successful, remove the appointment date from the session and display a success message
      session.delete(:appointment_date)
      flash[:success] = "Appointment was successfully created."
      # Update the AiScheduler instance if this appointment matches the suggested one
      if suggested_appointment.present? && 
         suggested_appointment.doctor_id == @appointment.doctor_id && 
         suggested_appointment.date == @appointment.appointment_date
        suggested_appointment.update(has_taken_appointment: true)
      end
      redirect_to dashboard_path
    else
      # If unsuccessful, display an error message and render the choose_time view again
      flash.now[:error] = "An error occurred while creating the appointment."
      prepare_appointment
      render :choose_time
    end
  end
  
  
  private

   # Set up necessary variables for appointment creation and time selection
   def prepare_appointment
    # Fetch the chosen doctor and current patient
    @doctor = Doctor.find(params[:doctor_id])
    @patient = current_patient
    # Build a new appointment for the current patient and chosen doctor
    @appointment = @patient.appointments.build(doctor: @doctor)
    # Parse the chosen date from the session
    @appointment_date = Date.parse(session[:appointment_date])
    # Define the range of possible appointment times
    @all_times = (9..12).to_a + (14..20).to_a
    # Find when the doctor already has appointments on the chosen date
    existing_appointment_times = @doctor.appointments.where(appointment_date: @appointment_date).pluck(:appointment_time).map { |time| time.hour }
    # Determine the times when the doctor is available
    @available_times = @all_times - existing_appointment_times
  end

  # Ensure the patient is logged in
  def logged_in_patient
    # If the patient is not logged in, display an error and redirect to the login page
    unless current_patient.present?
      flash[:danger] = "You need to log in to view appointments"
      redirect_to patients_sessions_path
    end
  end

  # Define the parameters allowed for creating an appointment
  def appointment_params  
    params.require(:appointment).permit(:appointment_date, :appointment_time, :doctor_id, :patient_id)
  end
end
