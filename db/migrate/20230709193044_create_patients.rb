class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.string :name
      t.date :date_of_birth
      t.string :email
      t.text :address

      t.timestamps
    end
  end
end
