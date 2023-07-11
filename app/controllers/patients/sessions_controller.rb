# app/controllers/patients/sessions_controller.rb
class Patients::SessionsController < ApplicationController
  def new
  end

  def create
    patient = Patient.find_by(email: params[:session][:email].downcase)
    if patient && patient.authenticate(params[:session][:password])
      session[:patient_id] = patient.id
      redirect_to dashboard_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    session.delete(:patient_id)
    @current_patient = nil
    redirect_to root_url
  end
end
