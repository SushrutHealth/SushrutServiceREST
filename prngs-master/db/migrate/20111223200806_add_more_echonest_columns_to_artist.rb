class AddMoreEchonestColumnsToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :hotttnesss, :decimal, :precision => 15, :scale => 10, :default => 0
    add_column :artists, :familiarity, :decimal, :precision => 15, :scale => 10, :default => 0
  end
end
