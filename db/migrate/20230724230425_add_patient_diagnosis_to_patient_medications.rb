class AddPatientDiagnosisToPatientMedications < ActiveRecord::Migration[6.1]
  def change
    add_reference :patient_medications, :patient_diagnosis, foreign_key: true
  end
end
