class Project < ActiveRecord::Base
  has_many :tasks
  has_many :comments
  belongs_to :creator, :class_name => 'User', :foreign_key => 'user_id'
end
