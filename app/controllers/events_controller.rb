class EventsController < ApplicationController
  def index
    @constituency = current_user.town.constituency if logged_in? && current_user.town
    @events = Event.find(:all, :conditions => ['time > ?', Time.now], :order => 'time ASC')
  end
end
