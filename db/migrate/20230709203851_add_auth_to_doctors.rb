class AddAuthToDoctors < ActiveRecord::Migration[6.1]
  def change
    add_column :doctors, :first_name, :string
    add_column :doctors, :last_name, :string
    add_column :doctors, :password_digest, :string
    add_column :doctors, :remember_token, :string
  end
end
