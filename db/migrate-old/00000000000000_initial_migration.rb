class InitialMigration < ActiveRecord::Migration
  def self.up
    create_table "constituencies", :force => true do |t|
      t.string "code"
      t.string "name"
    end
  
    create_table "ideas", :force => true do |t|
      t.text     "title"
      t.text     "body"
      t.integer  "score",      :default => 0
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "user_id"
    end
  
    create_table "townships", :force => true do |t|
      t.string  "code"
      t.string  "name"
      t.integer "constituency_id"
    end
  
    create_table "users", :force => true do |t|
      t.string   "email"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "remember_token"
      t.datetime "remember_token_expires_at"
      t.boolean  "is_admin",                                :default => false
      t.text     "name"
      t.string   "crypted_password"
      t.string   "salt"      
    end
  
    create_table "votes", :id => false, :force => true do |t|
      t.integer  "user_id"
      t.integer  "idea_id"
      t.boolean  "positive",   :default => true, :null => false
      t.datetime "created_at"
    end
  end

  def self.down
    raise IrreversibleMigration
  end
end
