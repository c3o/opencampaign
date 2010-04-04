class AddCommentsToConstituencies < ActiveRecord::Migration
  def self.up
    add_column :comments, :constituency_id, :integer
  end

  def self.down
  end
end
