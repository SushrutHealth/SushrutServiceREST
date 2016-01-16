class CreateAuthentications < ActiveRecord::Migration
  def up
    create_table :authentications do |t|
      t.string  :provider
      t.string  :uid
      t.integer :user_id

      t.timestamps
    end
  end

  def down
    drop_table :authentications
  end
end
