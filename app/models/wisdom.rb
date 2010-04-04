module Wisdom
  def rate_up
    self.class.transaction() do
      update_attribute(:rating, rating+1)
    end
  end

  def rate_down
    self.class.transaction() do
      update_attribute(:rating, rating-1)
    end
  end
end
