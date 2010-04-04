class AddPortraitToCandidates < ActiveRecord::Migration
  def self.up
    add_column :candidates, :portrait_file_name,    :string
    add_column :candidates, :portrait_content_type, :string
    add_column :candidates, :portrait_file_size,    :integer
    add_column :candidates, :portrait_updated_at,   :datetime
  end

  def self.down
  end
end
