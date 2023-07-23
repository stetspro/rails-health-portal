class AddDoctorToAiSchedulers < ActiveRecord::Migration[6.1]
  def change
    add_reference :ai_schedulers, :doctor, null: false, foreign_key: true
  end
end
