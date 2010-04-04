class DropTownship < ActiveRecord::Migration
  def self.up
    drop_table :townships
  end

  def self.down
  end
end
