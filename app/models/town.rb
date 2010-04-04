class Town < ActiveRecord::Base
  belongs_to :constituency
  #VIENNA = 17468..17490
  
  def self.vienna_districts
    Town.find(:all, :conditions => 'id >= 17468 AND id <= 17490')
  end
  
  def full_name
    if Town.vienna_districts.include?(self)
      "Wien #{name}"
    else
      name
    end
  end
  
end
