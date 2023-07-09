# app/controllers/doctors/registrations_controller.rb
class Doctors::RegistrationsController < ApplicationController
  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)
    if @doctor.save
      session[:doctor_id] = @doctor.id
      redirect_to @doctor
    else
      render 'new'
    end
  end

  private

  def doctor_params
    params.require(:doctor).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
