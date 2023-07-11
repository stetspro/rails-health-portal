class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  scope :today, -> { where(appointment_date: Date.current.beginning_of_day..Date.current.end_of_day) }
end
