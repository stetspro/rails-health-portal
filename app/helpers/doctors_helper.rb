module DoctorsHelper
  def current_time_in_appointment_range?(appointment)
    current_time = Time.now
    (appointment.appointment_time..appointment.appointment_time + 59.minutes).cover?(current_time)
  end
end
