class AddTasks < ActiveRecord::Migration
  def self.up
    create_table "tasks", :force => true do |t|
      t.text     "title"
      t.text     "body"
      t.boolean  "completed", :default => false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "tasks_users", :force => true do |t|
      t.text     "title"
      t.integer :user_id
      t.integer :task_id
    end
  end

  def self.down
    drop_table "tasks"
    drop_table "tasks_users"
  end
end
