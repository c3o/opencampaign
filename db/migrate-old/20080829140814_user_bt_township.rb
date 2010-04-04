class UserBtTownship < ActiveRecord::Migration
  def self.up
    add_column :users, :township_id, :integer
  end

  def self.down
  end
end
