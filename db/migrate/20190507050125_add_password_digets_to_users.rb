class AddPasswordDigetsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :password_digest, :string
    change_column_null :users, :password_digest, false
  end
end
