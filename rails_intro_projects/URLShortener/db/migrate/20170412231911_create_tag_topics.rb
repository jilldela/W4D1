class CreateTagTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :tag_topics do |t|
      t.string :topic, null: false
      t.integer :url_id
      t.timestamps
    end

    add_index :tag_topics, :url_id
  end
end
