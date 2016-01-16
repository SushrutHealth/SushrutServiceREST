class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :title
      t.integer :artist_id
      t.integer :album_id
      t.integer :label_id
      t.integer :mention_id
      t.string :rdio_url
      t.string :spotify_url

      t.timestamps
    end
  end
end
