class MapController < ApplicationController
  layout nil
  def constituency_styles
    cacheTime = Time.rfc2822(request.env["HTTP_IF_MODIFIED_SINCE"]) rescue nil
    newest_signup = (user = User.find(:first, :order => "created_at desc")) ? user.created_at : Time.now
    response.headers['Content-Type'] = 'application/vnd.google-earth.kml+xml'
    if cacheTime and newest_signup <= cacheTime
      return render :nothing => true, :status => 304
    else
      response.headers['Last-Modified'] = newest_signup.httpdate
      render :type => 'erb', :layout => false
    end
  end
  
  def index
    @map = GMap.new("map_div_id")  
    #@map.control_init(:small_map => true)
    @map.center_zoom_init([48.206371,16.373062], 11) #@map.center_zoom_init([48, 12.5], 6)
    @map.add_map_type_init(GMapType::G_PHYSICAL_MAP)
    @map.set_map_type_init(GMapType::G_PHYSICAL_MAP)
  end
end
