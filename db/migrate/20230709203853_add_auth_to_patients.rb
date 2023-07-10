class AddAuthToPatients < ActiveRecord::Migration[6.1]
  def change
    add_column :patients, :first_name, :string
    add_column :patients, :last_name, :string
    add_column :patients, :password_digest, :string
    add_column :patients, :remember_token, :string
  end
end
