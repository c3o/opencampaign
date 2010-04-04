class UseTown < ActiveRecord::Migration
  def self.up
    rename_column :users, :township_id, :town_id
    # Choose first town from the list of towns in gemeinde user has previously entered
    execute 'update users set town_id = (select id from towns where township_id=users.town_id)';
  end

  def self.down
  end
end
