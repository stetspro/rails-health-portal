class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  validates_uniqueness_of :appointment_time, scope: :doctor_id

  scope :today, -> { where(appointment_date: Date.current.beginning_of_day..Date.current.end_of_day) }
end
