class AddTitleToMentions < ActiveRecord::Migration
  def change
    add_column :mentions, :title, :string
  end
end
