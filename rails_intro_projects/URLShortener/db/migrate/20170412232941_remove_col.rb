class RemoveCol < ActiveRecord::Migration[5.0]
  def change
    remove_column :tag_topics, :url_id
  end
end
