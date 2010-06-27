module Admin
  class QuestionsController < ApplicationController
    layout 'admin'
    before_filter :login_required
    def index
      @questions = Question.find(:all, :order => 'created_at ASC') || []
    end
    
    def edit
      @question = Question.find(params[:id])
    end
    
    def show
      redirect_to questions_path
    end
    
protected
    def authorized?
      (logged_in? && current_user.is_admin) || request.host == 'localhost'
    end
  end
end
