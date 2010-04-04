class CreateComments < ActiveRecord::Migration
  def self.up
    create_table 'comments' do |t|
      t.text :body
      t.integer :user_id
      t.integer :idea_id
    end
  end

  def self.down
  end
end
