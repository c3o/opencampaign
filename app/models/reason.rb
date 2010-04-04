class Reason < ActiveRecord::Base
  include Wisdom
  
  belongs_to :user
  has_and_belongs_to_many :user_ratings, :class_name => "User", :join_table => :reason_ratings
  
  acts_as_taggable
end
