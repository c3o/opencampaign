class AddTeaserToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :teaser, :text    
  end

  def self.down
    remove_column :projects, :teaser
  end
end
