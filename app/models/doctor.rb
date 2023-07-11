class Doctor < ApplicationRecord
  has_secure_password
  belongs_to :hospital
  has_many :appointments
  has_many :patients, through: :appointments
end