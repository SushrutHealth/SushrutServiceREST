class RenameHotttnesssToPopularityOnArtists < ActiveRecord::Migration
  def change
    rename_column :artists, :hotttnesss, :popularity
  end
end
