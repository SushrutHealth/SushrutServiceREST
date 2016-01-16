class AddVideoIdToMentions < ActiveRecord::Migration
  def change
    add_column :mentions, :video_id, :integer
  end
end
