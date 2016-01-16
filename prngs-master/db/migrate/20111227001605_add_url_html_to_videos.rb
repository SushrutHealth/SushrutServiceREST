class AddUrlHtmlToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :url_html, :text
  end
end
