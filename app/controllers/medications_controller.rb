class MedicationsController < ApplicationController
  before_action :authenticate_patient!

  def index
    @patient = current_patient
    @patient_medications = @patient.patient_medications.includes(:medication).order("expiration_date DESC, medications.brand_name ASC")  end

end
