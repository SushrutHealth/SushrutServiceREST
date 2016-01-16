class AddIndexToAuthorsMentions < ActiveRecord::Migration
  def change
    add_index :authors_mentions, [:author_id, :mention_id]
  end
end
