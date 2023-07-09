class CreateDiagnoses < ActiveRecord::Migration[6.1]
  def change
    create_table :diagnoses do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
