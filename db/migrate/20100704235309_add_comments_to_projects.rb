class AddCommentsToProjects < ActiveRecord::Migration
  def self.up
    add_column :comments, :project_id, :integer
  end

  def self.down
    remove_column :comments, :project_id
  end
end
