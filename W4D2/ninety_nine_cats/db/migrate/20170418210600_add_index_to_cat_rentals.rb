class AddIndexToCatRentals < ActiveRecord::Migration[5.0]
  def change
    add_index :cat_rental_requests, :cat_id
  end
end
