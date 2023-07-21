class ModifyDiagnoses < ActiveRecord::Migration[6.0]
  def change
    remove_column :diagnoses, :description
    add_column :diagnoses, :is_chronic, :boolean, default: false
  end
end
