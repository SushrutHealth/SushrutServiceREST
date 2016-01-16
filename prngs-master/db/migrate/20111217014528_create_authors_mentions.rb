class CreateAuthorsMentions < ActiveRecord::Migration
  def up
    create_table :authors_mentions, :id => false do |t|
      t.integer :author_id
      t.integer :mention_id
    end
  end

  def down
    drop_table :authors_mentions
  end
end
