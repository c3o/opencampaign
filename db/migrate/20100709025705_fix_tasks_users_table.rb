class FixTasksUsersTable < ActiveRecord::Migration
  def self.up
    remove_column :tasks_users, :title
  end

  def self.down
    add_column :tasks_users, :title, :text
  end
end
