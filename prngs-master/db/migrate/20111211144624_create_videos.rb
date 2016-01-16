class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :artist_id
      t.string :title
      t.string :url
      t.string :kind

      t.timestamps
    end
  end
end
