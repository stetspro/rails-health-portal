class RemoveNameFromPatients < ActiveRecord::Migration[6.1]
  def change
    remove_column :patients, :name, :string
  end
end
