class StaticController < ApplicationController

  def index
    if @page = Page.find_by_path(request.path)
      render :template => 'static/page'
    elsif params[:path] && template_exists?(path = 'static/' + params[:path].join('/'))
      render :template => path
    elsif path && template_exists?(path += '/index')
      render :template => path
    else
      raise ::ActionController::RoutingError,
            "Recognition failed for #{request.path.inspect}"
    end
  end

end
