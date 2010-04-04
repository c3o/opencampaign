class StaticController < ApplicationController

  def index
    if template_exists? path = 'static/' + params[:path].join('/')
      render :template => path
    elsif template_exists? path += '/index'
      render :template => path
    else
      raise ::ActionController::RoutingError,
            "Recognition failed for #{request.path.inspect}"
    end
  end

end
