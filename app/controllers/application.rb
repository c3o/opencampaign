# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => '23dfba7f99792ab2a3a2f6d300268136'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password
  
  include AuthenticatedSystem
  
  # redirect all aliases to canonical domain
  HOSTNAME = CONFIG['hostname']
  before_filter :ensure_right_hostname
  def ensure_right_hostname
    redirect_to(request.protocol + HOSTNAME + request.request_uri) if (RAILS_ENV=='production') && (request.host.downcase != HOSTNAME)
  end
  
  before_filter :load_userwidget_data
  def load_userwidget_data
    @current_user_count = User.count_by_sql("SELECT count(id) FROM users") + (CONFIG["progress_start_at"] || 0)
    @current_user_percent = @current_user_count / (CONFIG["progress_required_users"]/100)
  end
  
  before_filter :check_fb_connect
  def check_fb_connect
    #cookie_id = ('fbs_'+CONFIG[:Facebook]['appid'].to_s).to_sym
    #puts '*******'+cookies[cookie_id] if cookie_id     cookies[:fb_user_id] &&
    if cookies[:fb_user_id] && u = User.find_by_facebook_id(cookies[:fb_user_id])
      ##puts '%%%%%%%%%%'+u.id.to_s
      session[:user_id] = u.id
    end
  end
  
  def check_authorization(obj)
    if current_user
      return true if current_user.is_admin
      return true if obj.user == current_user rescue nil
      return true if obj.creator == current_user rescue nil
    end
    return false
  end
end
