class AddDataToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :body, :text
    add_column :questions, :user_id, :integer
  end

  def self.down
    remove_column :questions, :body
    remove_column :questions, :user_id
  end
end
