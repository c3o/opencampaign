class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :title
      t.text :body
      t.integer :user_id
      t.timestamps
    end
    add_column :tasks, :project_id, :integer
  end

  def self.down
    drop_table :projects
    remove_column :tasks, :project_id
  end
end
