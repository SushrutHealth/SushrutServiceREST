class AddUniqueIndexToVideosOnTitle < ActiveRecord::Migration
  def change
    add_index :videos, :title, :unique => true
  end
end
