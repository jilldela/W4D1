class UpdateUserPremium < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :premium, :boolean, default: false
  end
end
