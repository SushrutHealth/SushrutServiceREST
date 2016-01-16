class CreateArtistsVideos < ActiveRecord::Migration
  def change
    create_table :artists_videos, :id => false do |t|
      t.integer :artist_id
      t.integer :video_id
    end
    add_index :artists_videos, [:artist_id, :video_id]
  end
end
