class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.integer :source_id
      t.integer :author_id
      t.text :text
      t.string :url
      t.decimal :rating
      t.string :sentiment
      t.datetime :date

      t.timestamps
    end
  end
end
