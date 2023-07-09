class Patient < ApplicationRecord
  has_many :patient_diagnoses
  has_many :diagnoses, through: :patient_diagnoses
  has_many :appointments
  has_many :medications
end