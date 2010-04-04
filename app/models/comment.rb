class Comment < ActiveRecord::Base
  belongs_to :author, :class_name => 'User', :foreign_key => 'user_id'
  
  belongs_to :idea # -------XOR 
  belongs_to :constituency # |
  
  attr_accessible :body
end
