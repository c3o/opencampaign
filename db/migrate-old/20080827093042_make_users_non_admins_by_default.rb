class MakeUsersNonAdminsByDefault < ActiveRecord::Migration
  def self.up
    change_column :users, :is_admin, :boolean, :default => false
  end

  def self.down
  end
end
