class DoctorsController < ApplicationController

  def new
    @doctor = Doctor.new
  end

  def daily_patients
    @doctor = Doctor.includes(appointments: :patient).find(params[:id])
    @appointments = @doctor.appointments.where(appointment_date: Date.today).order(:appointment_time)
  end
  
  def current_time_in_appointment_range?(appointment)
    current_time = Time.now
    (appointment.appointment_time..appointment.appointment_time + 59.minutes).cover?(current_time)
  end
  
  private
  def doctor_params
    params.require(:doctor).permit(:name, :specialization, :email, :address)
  end
end