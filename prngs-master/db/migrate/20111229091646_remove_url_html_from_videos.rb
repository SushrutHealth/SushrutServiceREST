class RemoveUrlHtmlFromVideos < ActiveRecord::Migration
  def up
    remove_column :videos, :url_html
  end

  def down
    add_column :videos, :url_html, :text
  end
end
