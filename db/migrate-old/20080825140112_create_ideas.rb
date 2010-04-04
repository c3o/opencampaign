class CreateIdeas < ActiveRecord::Migration
  def self.up
    create_table :ideas do |t|
      t.text :title
      t.text :body
      t.integer :rating

      t.timestamps
    end
  end

  def self.down
    drop_table :ideas
  end
end
