class RedirectController < ApplicationController

  def index
    uri = 'http://web.arminsoyka.at' + request.env["REQUEST_URI"]
    #render :text => uri and return
    redirect_to uri and return
  end

end