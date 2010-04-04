class AddOfficialToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :is_official, :boolean, :default => false
  end

  def self.down
  end
end
