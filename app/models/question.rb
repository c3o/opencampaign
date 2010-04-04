class Question < ActiveRecord::Base
  belongs_to :author, :class_name => 'User', :foreign_key => 'user_id'
  has_many :comments

  validates_presence_of :body => 'ist leer'

end
