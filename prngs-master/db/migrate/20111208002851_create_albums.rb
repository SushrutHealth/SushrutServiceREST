class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.integer :artist_id
      t.integer :label_id
      t.string :rdio_url
      t.string :spotify_url

      t.timestamps
    end
  end
end
