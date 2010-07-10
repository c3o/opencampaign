module Admin
  class EventsController < ApplicationController
    layout 'admin'
    before_filter :login_required
    
    def adminindex
      @usercount = User.count
      @ideacount = Idea.count
      @videocount = Video.count
      @questioncount = Question.count
      @taskcount = Task.count
      @videocount_unmoderated = Video.find(:all, :conditions => ['is_approved = ?', false]).size
      @openquestions = Question.find(:all, :conditions => ['reply IS NULL'], :order => 'created_at DESC')
      @commentcount = Comment.count
      @comments = Comment.find(:all, :order => 'created_at DESC', :limit => 20)
    end
    
    def index
      @events = Event.find(:all, :order => 'time ASC') || []
    end
    
    def edit
      @event = Event.find(params[:id])
    end
    
    def update
      @event = Event.find(params[:id])
      @event.update_attributes(params[:event])
      redirect_to events_path
    end
    
    def create
      Event.create(params[:event])
      redirect_to events_path
      # TODO: Send email notification to users in this Constituency
    end
    
    def destroy
      @event = Event.find(params[:id])
      @event.destroy
      redirect_to events_path
    end
    
protected
    def authorized?
      logged_in? && current_user.is_admin
    end
  end
end
