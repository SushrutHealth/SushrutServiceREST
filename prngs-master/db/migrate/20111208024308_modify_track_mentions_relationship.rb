class ModifyTrackMentionsRelationship < ActiveRecord::Migration
  def up
    remove_column :tracks, :mention_id
    add_column :mentions, :track_id, :integer
    add_column :mentions, :album_id, :integer
  end

  def down
    remove_column :mentions, :album_id
    remove_column :mentions, :track_id
    add_column :tracks, :mention_id, :integer
  end
end
