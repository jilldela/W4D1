class RemoveNullFromStatus < ActiveRecord::Migration[5.0]
  def change
    change_column :cat_rental_requests, :status, :string, null: true
  end
end
