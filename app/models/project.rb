class Project < ActiveRecord::Base
  has_many :tasks
  belongs_to :creator, :class_name => 'User', :foreign_key => 'user_id'
end
