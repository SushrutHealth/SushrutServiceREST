class DropTracks < ActiveRecord::Migration
  def up
    drop_table :tracks
  end

  def down
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
