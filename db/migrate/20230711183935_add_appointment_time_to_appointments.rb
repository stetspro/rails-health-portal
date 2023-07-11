class AddAppointmentTimeToAppointments < ActiveRecord::Migration[6.1]
  def change
    add_column :appointments, :appointment_time, :time
  end
end
