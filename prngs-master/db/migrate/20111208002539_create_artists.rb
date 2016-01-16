class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.string :sound
      t.string :rdio_url
      t.string :spotify_url

      t.timestamps
    end
  end
end
