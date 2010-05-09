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
    
    def update
      @project = Project.find(params[:id])
      @project.update_attributes(params[:project])
      redirect_to adminprojects_path
    end
    
    def create
      Project.create(params[:candidate])
      redirect_to adminprojects_path
    end
    
    def destroy
      @project = Project.find(params[:id])
      @project.destroy
      redirect_to adminprojects_path
    end
    
protected
    def authorized?
      (logged_in? && current_user.is_admin) || request.host == 'localhost'
    end
  end
end
