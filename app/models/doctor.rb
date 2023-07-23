class Doctor < ApplicationRecord
  has_secure_password
  belongs_to :hospital
  has_many :appointments
  has_many :patients, through: :appointments
  has_many :ai_schedulers

  def full_name
    "#{first_name} #{last_name}"
  end
end