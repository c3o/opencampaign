# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  skip_before_filter :verify_authenticity_token
  
  def create
    self.current_user = User.authenticate(params[:email], params[:password])
    if logged_in?
      render :update do |page|
        page << "Signup.restore()"
      end
    else
      render :update do |page|
        errors = {'mailaddr' => 'wurde nicht gefunden, oder Passwort ist ungültig.'}
        page << "Signup.handle_form_errors(#{errors.to_json})"
      end
    end
  end

  def destroy
    reset_session
    cookies.delete :fb_user_id if cookies[:fb_user_id]
    redirect_back_or_default('/')
  end
  
end
