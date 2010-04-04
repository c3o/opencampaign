class AddNameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :text
  end

  def self.down
    remove_column :users, :name
  end
end
