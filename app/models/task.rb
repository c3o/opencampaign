class Task < ActiveRecord::Base
  has_and_belongs_to_many :participants, :class_name => 'User', :foreign_key => 'user_id'
  has_many :comments
end
