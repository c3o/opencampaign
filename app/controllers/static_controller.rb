class StaticController < ApplicationController

  def index
    if template_exists? path = 'static/' + params[:path].join('/')
      render :template => path
    elsif template_exists? path += '/index'
      render :template => path
    elsif p = Page.find_by_path(request.path)
      render :text => p.body, :layout => true
    else
      raise ::ActionController::RoutingError,
            "Recognition failed for #{request.path.inspect}"
    end
  end

end
