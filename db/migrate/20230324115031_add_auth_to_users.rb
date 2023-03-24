class AddAuthToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :auth, :string
  end
end
