class AddUnique < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :username, :string

    add_index :users, :username, unique: true
  end
end
