class Patient < ApplicationRecord
  has_secure_password
  has_many :patient_diagnoses
  has_many :diagnoses, through: :patient_diagnoses
  has_many :appointments
  has_many :medications
  has_many :ai_schedulers
end