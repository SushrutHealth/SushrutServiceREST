class AddFeedUrlsToSources < ActiveRecord::Migration
  def change
    add_column :sources, :feeds, :text
  end
end
