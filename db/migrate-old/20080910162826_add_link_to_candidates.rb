class AddLinkToCandidates < ActiveRecord::Migration
  def self.up
    add_column :candidates, :link, :string
  end

  def self.down
  end
end
