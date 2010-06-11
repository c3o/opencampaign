class AddFacebookIdToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :facebook_id, :bigint    
    change_column :users, :facebook_id, :bigint    
  end

  def self.down
    remove_column :events, :facebook_id
    change_column :users, :facebook_id, :integer    
  end
end
