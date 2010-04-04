class AddVideos < ActiveRecord::Migration
  def self.up
    create_table "videos", :force => true do |t|
      t.integer :user_id
      t.text     "title"
      t.text     "url"
      t.boolean  "is_approved", :default => false
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down
    drop_table "videos"
  end
end
