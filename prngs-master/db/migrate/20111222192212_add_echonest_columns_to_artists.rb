class AddEchonestColumnsToArtists < ActiveRecord::Migration
  def up
    remove_column :artists, :sound
    remove_column :artists, :lastfm_url
    remove_column :artists, :rdio_url
    remove_column :artists, :spotify_url
    remove_column :artists, :image
    add_column :artists, :echonest_id, :string
    add_column :artists, :images, :text
    add_column :artists, :biographies, :text
  end

  def down
    remove_column :artists, :echonest_id
    remove_column :artists, :images
    remove_column :artists, :biographies
    add_column :artists, :sound, :string
    add_column :artists, :lastfm_url, :string
    add_column :artists, :rdio_url, :string
    add_column :artists, :spotify_url, :string
    add_column :artists, :image, :string
  end
end
