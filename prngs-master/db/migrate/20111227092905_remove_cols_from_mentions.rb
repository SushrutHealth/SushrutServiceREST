class RemoveColsFromMentions < ActiveRecord::Migration
  def up
    remove_column :mentions, :album_id
    remove_column :mentions, :track_id
    remove_column :mentions, :rating
    remove_column :mentions, :sentiment
  end

  def down
    add_column :mentions, :album_id, :integer
    add_column :mentions, :track_id, :integer
    add_column :mentions, :rating, :precision => 10, :scale => 0
    add_column :mentions, :sentiment, :string
  end
end
