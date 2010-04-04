class AddAuditTrail < ActiveRecord::Migration
  def self.up
    create_table :idea_ratings, :force => true, :id => false do |t|
      t.integer :user_id
      t.integer :wisdom_id
    end
    create_table :reason_ratings, :force => true, :id => false do |t|
      t.integer :user_id
      t.integer :reason_id
    end

    add_column :ideas, :user_id, :integer
    add_column :reasons, :user_id, :integer
  end

  def self.down
    remove_column :reasons, :user_id
    remove_column :ideas, :user_id
    drop_table :user_ratings
  end
end
