class CreatePatientMedications < ActiveRecord::Migration[6.1]
  def change
    create_table :patient_medications do |t|
      t.references :patient, null: false, foreign_key: true
      t.references :medication, null: false, foreign_key: true
      t.date :expiration_date

      t.timestamps
    end
  end
end
