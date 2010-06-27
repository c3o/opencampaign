module Admin
  class ProjectsController < ApplicationController
    layout 'admin'
    before_filter :login_required
    def index
      @projects = Project.find(:all, :order => 'created_at ASC') || []
    end
    
    def edit
      @project = Project.find(params[:id])
    end

    def show
      redirect_to projects_path
    end
        
protected
    def authorized?
      (logged_in? && current_user.is_admin) || request.host == 'localhost'
    end
  end
end
