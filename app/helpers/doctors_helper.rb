module DoctorsHelper
  def current_time_in_appointment_range?(appointment)
    current_date = Time.current
    current_time_only = Time.current.seconds_since_midnight

    appointment_start_time = appointment.appointment_time.seconds_since_midnight
    appointment_end_time = appointment_start_time + 59.minutes
    # Check if the current time (only) is within the appointment time range
    in_range = (appointment_start_time..appointment_end_time).cover?(current_time_only)

    # Log debugging information
     # Log debugging information
     Rails.logger.debug "Current date: #{current_date}"
  Rails.logger.debug "Current time: #{current_time_only}"
  Rails.logger.debug "Appointment start time: #{appointment_start_time}"
  Rails.logger.debug "Appointment end time: #{appointment_end_time}"
  Rails.logger.debug "In range: #{in_range}"
  
    in_range
  end
end
