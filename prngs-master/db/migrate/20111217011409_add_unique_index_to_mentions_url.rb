class AddUniqueIndexToMentionsUrl < ActiveRecord::Migration
  def change
    add_index :mentions, :url, :unique => true
  end
end
