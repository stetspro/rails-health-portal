class AppointmentsController < ApplicationController
  before_action :logged_in_patient

  def index
    @appointments = current_patient.appointments
  end


  private

  def logged_in_patient
    unless current_patient.present?
      flash[:danger] = "You need to log in to view appointments"
      redirect_to login_path # or wherever your login route is
    end
  end
end
