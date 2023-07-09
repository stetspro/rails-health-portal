class Doctor < ApplicationRecord
  belongs_to :hospital
  has_many :appointments
end