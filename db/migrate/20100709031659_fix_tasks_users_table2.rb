class FixTasksUsersTable2 < ActiveRecord::Migration
  def self.up
    remove_column :tasks_users, :id
  end

  def self.down
    add_column :tasks_users, :id, :integer
  end
end
