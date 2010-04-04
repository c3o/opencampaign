class UserController < ApplicationController
  def signup
    password = @user.signup_as(params[:email], params[:zip], params[:name])
    Notifier.deliver_signup_thanks(@user, password)
    render :update do |page|
      page.replace_html 'signup', :string => "Danke!"
    end
  end
  
  def login
    if request.post?
      easy_login(User.authenticate(params[:email], params[:password]))
    end
  end
end
