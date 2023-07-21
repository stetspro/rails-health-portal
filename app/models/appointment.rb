class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  validates :appointment_time, uniqueness: { scope: [:doctor_id, :appointment_date] }

  scope :today, -> { where(appointment_date: Date.current.beginning_of_day..Date.current.end_of_day) }
end
