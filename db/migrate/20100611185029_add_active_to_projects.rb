class AddActiveToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :is_active, :boolean
  end

  def self.down
    remove_column :projects, :is_active
  end
end
