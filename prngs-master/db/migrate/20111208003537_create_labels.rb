class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.string :name
      t.string :rdio_url

      t.timestamps
    end
  end
end
