class AddSlugToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :slug, :string
  end

  def self.down
    remove_column :projects, :slug
  end
end
