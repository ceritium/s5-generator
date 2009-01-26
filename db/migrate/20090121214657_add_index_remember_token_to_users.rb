class AddIndexRememberTokenToUsers < ActiveRecord::Migration
  def self.up
    add_index :users, :remember_token
  end

  def self.down
    remove_index :users, :remember_token
  end
end
