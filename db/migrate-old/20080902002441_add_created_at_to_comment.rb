class AddCreatedAtToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :created_at, :datetime
  end

  def self.down
  end
end
