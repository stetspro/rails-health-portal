class CreateMedications < ActiveRecord::Migration[6.1]
  def change
    create_table :medications do |t|
      t.references :patient, null: false, foreign_key: true
      t.string :name
      t.string :dosage
      t.string :frequency
      t.date :expiration_date

      t.timestamps
    end
  end
end
