class Candidate < ActiveRecord::Base
  belongs_to :constituency
  has_attached_file :portrait, :styles => { :regular => "150x220", :thumb => "40x60"  }
end
