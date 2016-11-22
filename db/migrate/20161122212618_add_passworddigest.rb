class AddPassworddigest < ActiveRecord::Migration[5.0]
  def change
    add_column :teachers, :password_digest, :string
  end
end
