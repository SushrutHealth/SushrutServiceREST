class RemoveArtistIdFromVideos < ActiveRecord::Migration
  def up
    remove_column :videos, :artist_id
  end

  def down
    add_column :videos, :artist_id, :integer
  end
end
