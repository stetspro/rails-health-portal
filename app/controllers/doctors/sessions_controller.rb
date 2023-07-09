# app/controllers/doctors/sessions_controller.rb
class Doctors::SessionsController < ApplicationController
  def new
  end

  def create
    doctor = Doctor.find_by(email: params[:session][:email].downcase)
    if doctor && doctor.authenticate(params[:session][:password])
      session[:doctor_id] = doctor.id
      redirect_to doctor
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    session.delete(:doctor_id)
    @current_doctor = nil
    redirect_to root_url
  end
end
