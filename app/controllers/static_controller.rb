class StaticController < ApplicationController

  def index
    if template_exists? path = 'static/' + params[:path].join('/')
      render :template => path
    elsif template_exists? path += '/index'
      render :template => path
    elsif @page = Page.find_by_path(request.path)
      render :template => 'static/page'
    else
      raise ::ActionController::RoutingError,
            "Recognition failed for #{request.path.inspect}"
    end
  end

end
