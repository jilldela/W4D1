class AddPremiumtoUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :premium, :bool, {premium: false}
  end
end
