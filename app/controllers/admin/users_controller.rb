module Admin
  class UsersController < ApplicationController
    layout 'admin'
    before_filter :login_required

    def index
      @users = User.find(:all, :order => 'created_at ASC') || []
    end
    
    def make_official
      u = User.find(params[:id])
      u.is_official = !u.is_official
      u.save
      redirect_to adminusers_url
    end
        
protected
    def authorized?
      (logged_in? && current_user.is_admin) || request.host == 'localhost'
    end
  end
end
