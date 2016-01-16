class CreateUsersVideos < ActiveRecord::Migration
  def up
    create_table :users_videos, :id => false do |t|
      t.integer :user_id
      t.integer :video_id
    end
  end

  def down
    drop_table :users_videos
  end
end
