class Doctor < ApplicationRecord
  has_secure_password
  belongs_to :hospital
  has_many :appointments
end