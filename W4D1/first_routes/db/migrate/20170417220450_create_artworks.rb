class CreateArtworks < ActiveRecord::Migration[5.0]
  def change
    create_table :artworks do |t|
      t.string :title, null: false
      t.string :image_url, null: false
      t.integer :artist_id, null: false

      t.timestamps
    end

    add_index :artworks, [:title, :artist_id], unique: true
    add_index :artworks, :image_url, unique: true
  end
end
