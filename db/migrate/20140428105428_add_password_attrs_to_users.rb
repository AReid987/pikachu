class AddPasswordAttrsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :password_hash, :string, :password_salt, :string 
  end
end
