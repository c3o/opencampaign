class EventsHaveTime < ActiveRecord::Migration
  def self.up
    change_column :events, :date, :datetime
    rename_column :events, :date, :time
  end

  def self.down
  end
end
