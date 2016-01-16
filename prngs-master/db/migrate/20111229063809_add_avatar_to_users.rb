class AddAvatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook_link, :string
    add_column :users, :twitter_avatar, :text
    rename_column :users, :handle, :twitter_handle
  end
end
