class CreateTowns < ActiveRecord::Migration
  def self.up
    create_table :towns do |t|
      t.string :name
      t.string :code
      t.integer :township_id
      t.integer :constituency_id
    end
  end

  def self.down
    drop_table :towns
  end
end
