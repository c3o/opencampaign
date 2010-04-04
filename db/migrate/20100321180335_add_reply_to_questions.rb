class AddReplyToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :reply, :text
    add_column :questions, :reply_created, :timestamp
    add_column :questions, :reply_updated, :timestamp
  end

  def self.down
    remove_column :questions, :reply
    remove_column :questions, :reply_created
    remove_column :questions, :reply_updated
  end
end
