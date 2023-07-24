class PatientDiagnosis < ApplicationRecord
  belongs_to :patient
  belongs_to :diagnosis
  has_one :ai_scheduler
end