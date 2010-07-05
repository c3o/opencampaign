module Admin
  class PagesController < ApplicationController
    layout 'admin'
    before_filter :login_required
    def index
      @pages = Page.find(:all, :order => 'created_at ASC') || []
    end
    
    def edit
      @page = Page.find(params[:id])
    end

    def update
      @page = Page.find(params[:id])
      @page.update_attributes(params[:page])
      redirect_to @page.path
    end

    def create
      p = Page.create(params[:page])
      redirect_to p.path
    end
    
    def destroy
      @page = Page.find(params[:id])
      @page.destroy
      redirect_to pages_path
    end
    
    def show
      redirect_to @page.path
    end
        
protected
    def authorized?
      (logged_in? && current_user.is_admin) || request.host == 'localhost'
    end
  end
end
