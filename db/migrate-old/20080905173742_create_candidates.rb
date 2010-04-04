class CreateCandidates < ActiveRecord::Migration
  def self.up
    create_table :candidates do |t|
      t.string :name
      t.string :email
      t.integer :constituency_id
    end
  end

  def self.down
  end
end
