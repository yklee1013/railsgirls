class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string   :provider,   :limit => 16
      t.string   :uid,        :limit => 64
      t.string   :token
      t.string   :secret
      t.belongs_to :user
      t.timestamps
    end
    add_index :authentications, :provider
    add_index :authentications, :uid
  end
end
