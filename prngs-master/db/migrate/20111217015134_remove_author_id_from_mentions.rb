class RemoveAuthorIdFromMentions < ActiveRecord::Migration
  def up
    remove_column :mentions, :author_id
  end

  def down
    add_column :mentions, :author_id, :integer
  end
end
