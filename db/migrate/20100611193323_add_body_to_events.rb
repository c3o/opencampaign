class AddBodyToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :body, :text    
  end

  def self.down
    remove_column :events, :body
  end
end
