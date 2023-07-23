class AiScheduler < ApplicationRecord
  belongs_to :patient
  belongs_to :patient_diagnosis
  belongs_to :doctor
end