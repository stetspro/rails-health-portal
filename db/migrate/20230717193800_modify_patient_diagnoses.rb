class ModifyPatientDiagnoses < ActiveRecord::Migration[6.0]
  def change
    remove_column :patient_diagnoses, :is_chronic
    add_column :patient_diagnoses, :complaint, :string
  end
end
