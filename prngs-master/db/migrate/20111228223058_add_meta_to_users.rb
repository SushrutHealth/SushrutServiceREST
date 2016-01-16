class AddMetaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :handle, :string
  end
end
