class MedicationsController < ApplicationController
  before_action :authenticate_patient!
  before_action :restrict_patient!

  def index
    @patient = current_patient
    @patient_medications = @patient.patient_medications
  end

end
