class AddFieldsToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :video_id, :string
    add_column :videos, :provider, :string
    add_column :videos, :description, :text
    add_column :videos, :keywords, :text
    add_column :videos, :duration, :integer
    add_column :videos, :date, :datetime
    add_column :videos, :thumbnail_small, :string
    add_column :videos, :thumbnail_large, :string
    add_column :videos, :width, :integer
    add_column :videos, :height, :integer
    remove_column :videos, :kind
  end
end
