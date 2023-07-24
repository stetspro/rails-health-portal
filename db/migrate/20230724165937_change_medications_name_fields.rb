class ChangeMedicationsNameFields < ActiveRecord::Migration[6.1]
  def change
    remove_column :medications, :name
    add_column :medications, :pharmacological_name, :string
    add_column :medications, :brand_name, :string
  end
end
