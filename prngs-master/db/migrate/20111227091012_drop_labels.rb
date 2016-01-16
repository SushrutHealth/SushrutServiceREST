class DropLabels < ActiveRecord::Migration
  def up
    drop_table :labels
  end

  def down
    create_table :labels do |t|
      t.string :name
      t.string :rdio_url

      t.timestamps
    end
  end
end
