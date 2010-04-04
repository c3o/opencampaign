class WelcomeController < ApplicationController
  def index
    @map = GMap.new("map_div_id")  
    @map.control_init(:small_map => true)
    @map.center_zoom_init([48.206371,16.373062], 11)
    @map.add_map_type_init(GMapType::G_PHYSICAL_MAP)
    @map.set_map_type_init(GMapType::G_PHYSICAL_MAP)
  end
end