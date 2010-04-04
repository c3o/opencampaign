class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.date :date
      t.string :title
      t.string :location
      t.integer :constituency_id
    end
  end

  def self.down
    drop_table :events
  end
end
