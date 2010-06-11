class Comment < ActiveRecord::Base
  belongs_to :author, :class_name => 'User', :foreign_key => 'user_id'
  
  belongs_to :idea # -------XOR 
  belongs_to :constituency # |
  belongs_to :task # |
  belongs_to :question # |
  
  attr_accessible :body
end
