class Event < ActiveRecord::Base
  belongs_to :constituency
  
  def day
    self.time.day
  end
  
  def month
    %w(JAN FEB MAR APR MAI JUN JUL AUG SEP OKT NOV DEZ)[self.time.month-1]
  end
end
