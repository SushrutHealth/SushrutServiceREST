class DropIdentities < ActiveRecord::Migration
  def up
    drop_table :identities
  end

  def down
    create_table :identities do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
