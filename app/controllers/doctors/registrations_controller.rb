class Doctors::RegistrationsController < ApplicationController
  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)
    if @doctor.save
      session[:doctor_id] = @doctor.id
      redirect_to daily_patients_doctor_path(@doctor)
    else
      render 'new'
    end
  end

  private

  def doctor_params
    params.require(:doctor).permit(:first_name, :last_name, :email, :specialty, :hospital_id, :password, :password_confirmation)
  end
end
