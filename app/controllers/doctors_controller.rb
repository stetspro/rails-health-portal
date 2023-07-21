class DoctorsController < ApplicationController

  def new
    @doctor = Doctor.new
  end

  def daily_patients
    @doctor = Doctor.includes(appointments: :patient).find(params[:id])
    @appointments = @doctor.appointments.where(appointment_date: Date.new(2023,7,20)).order(:appointment_time)
  end
  
  private
  def doctor_params
    params.require(:doctor).permit(:name, :specialization, :email, :address)
  end
end