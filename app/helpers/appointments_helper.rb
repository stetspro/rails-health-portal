module AppointmentsHelper
  # generate an array of half-hour time slots that the user can choose from
  def time_slots
    start_time = Time.parse("9:00")
    end_time = Time.parse("20:00")
    time_slots = []
    while start_time <= end_time
      time_slots << start_time.strftime("%I:%M %p")
      start_time += 30.minutes
    end
    time_slots
  end
end
