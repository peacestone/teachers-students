class AddUsernameEmail < ActiveRecord::Migration[5.0]
  def change
    add_column :teachers, :username, :string
    add_column :teachers, :email, :string
  end
end
