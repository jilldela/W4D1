class ChangeComments < ActiveRecord::Migration[5.0]
  def change
    remove_index :comments, :artwork_id
    remove_index :comments, :user_id
  end
end
