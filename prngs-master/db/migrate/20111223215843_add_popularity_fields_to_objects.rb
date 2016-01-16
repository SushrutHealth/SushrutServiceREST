class AddPopularityFieldsToObjects < ActiveRecord::Migration
  def change
    add_column :sources, :popularity, :integer
    add_column :videos, :popularity, :integer
  end
end
