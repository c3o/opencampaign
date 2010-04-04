module Admin
  class CandidatesController < ApplicationController
    layout 'admin'
    before_filter :login_required
    def index
      @candidates = Candidate.find(:all, :order => 'constituency_id ASC') || []
    end
    
    def edit
      @candidate = Candidate.find(params[:id])
    end
    
    def update
      @candidate = Candidate.find(params[:id])
      @candidate.update_attributes(params[:candidate])
      redirect_to candidates_path
    end
    
    def create
      Candidate.create(params[:candidate])
      redirect_to candidates_path
    end
    
    def destroy
      @candidate = Candidate.find(params[:id])
      @candidate.destroy
      redirect_to candidates_path
    end
    
protected
    def authorized?
      logged_in? && current_user.is_admin
    end
  end
end
