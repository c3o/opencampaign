class Project < ActiveRecord::Base
  has_many :tasks
  has_many :comments
  belongs_to :creator, :class_name => 'User', :foreign_key => 'user_id'

  def active_tasks
    tasks.reject { |t| t.completed }
  end
end
