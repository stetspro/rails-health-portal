class ApplicationController < ActionController::Base
  helper_method :current_patient

  def current_patient
    @current_patient ||= Patient.find(session[:patient_id]) if session[:patient_id]
  end

  def authenticate_patient!
    redirect_to new_patient_session_path unless current_patient
  end

  def restrict_patient!
    @patient = Patient.find(params[:id])
    unless @patient == current_patient
      redirect_to dashboard_path, alert: "You are not authorized to access this page"
    end
  end
end
