class AddLastFmColsToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :lastfm_url, :string
    add_column :artists, :image, :string
  end
end
