class PatientDiagnosis < ApplicationRecord
  belongs_to :patient
  belongs_to :diagnosis
  has_one :ai_scheduler
  has_many :patient_medications
  has_many :medications, through: :patient_medications
end