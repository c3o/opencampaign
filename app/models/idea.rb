class Idea < ActiveRecord::Base
  belongs_to :author, :class_name => 'User', :foreign_key => 'user_id'
  has_many :votes, :include => :user
  has_many :comments
  
  validates_presence_of :title, :body, :message => 'ist leer'
  
  DEFAULT_SCORE = 1
  
  def vote!(user,score)
    return if votes_by_users.include?(user) # Already voted
    self.score += score
    self.votes << Vote.new(:user_id => user.id, :positive => (score > 0))
    self.save
  end
  
  def votes_by_users
    return Hash[*(self.votes.map { |v| [v.user,v.positive] }.flatten)]
  end
  
  def before_create
    self.score = DEFAULT_SCORE
  end
end
