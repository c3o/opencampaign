class Users < ActiveRecord::Migration
  def self.up
    add_column :users, :facebook_id, :integer    
    add_column :users, :birthday, :timestamp    
  end

  def self.down
    remove_column :users, :facebook_id
    remove_column :users, :birthday
  end
end
