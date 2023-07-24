class CreateAiSchedulers < ActiveRecord::Migration[6.1]
  def change
    create_table :ai_schedulers do |t|
      t.references :patient, null: false, foreign_key: true
      t.date :date
      t.references :patient_diagnosis, null: false, foreign_key: true
      t.boolean :has_taken_appointment

      t.timestamps
    end
  end
end
