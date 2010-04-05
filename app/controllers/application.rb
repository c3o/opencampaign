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
  
  # redirect all aliases to test.arminsoyka.at
  HOSTNAME = 'test.arminsoyka.at'
  before_filter :ensure_right_hostname
  def ensure_right_hostname
    redirect_to(request.protocol + HOSTNAME + request.request_uri) if (RAILS_ENV=='production') && (request.host.downcase != HOSTNAME)
  end
end
