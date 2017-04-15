class CreateResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :responses do |t|
      t.integer :answer_id
      t.integer :user_id
      t.timestamps
    end

    add_index :responses, :answer_id
    add_index :responses, :user_id
  end
end
