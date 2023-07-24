class RemoveExpirationDateFromMedications < ActiveRecord::Migration[6.1]
  def change
    remove_column :medications, :expiration_date, :date
  end
end
