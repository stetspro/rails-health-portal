class PatientMedication < ApplicationRecord
  belongs_to :patient
  belongs_to :medication
  belongs_to :patient_diagnosis, optional: true
end
