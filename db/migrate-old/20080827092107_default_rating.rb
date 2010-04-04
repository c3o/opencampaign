class DefaultRating < ActiveRecord::Migration
  def self.up
    change_column :reasons, :rating, :integer, :default => 0
    change_column :ideas, :rating, :integer, :default => 0
  end

  def self.down
  end
end
