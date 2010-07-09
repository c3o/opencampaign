class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :creator, :class_name => 'User', :foreign_key => 'user_id'
  has_and_belongs_to_many :participants, :class_name => 'User'
  has_many :comments
end
