class DropAuthors < ActiveRecord::Migration
  def up
    drop_table :authors_mentions
    drop_table :authors
  end

  def down
    create_table :authors do |t|
      t.string :name
      t.string :url
      t.string :kind

      t.timestamps
    end
  end
end
