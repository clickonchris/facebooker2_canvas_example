class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :facebook_id
      t.string :access_token
      t.timestamp :access_token_expires

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
