module Admin
  class UsersController < ApplicationController
    layout 'admin'
    before_filter :login_required
    def index
      @users = User.find(:all, :order => 'created_at ASC') || []
    end
        
protected
    def authorized?
      (logged_in? && current_user.is_admin) || request.host == 'localhost'
    end
  end
end
