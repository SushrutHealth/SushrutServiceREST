class AddUniqueIndexToVideos < ActiveRecord::Migration
  def change
    add_index :videos, :video_id, :unique => true
  end
end
