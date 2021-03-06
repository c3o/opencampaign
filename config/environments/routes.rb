# See how all your routes lay out with "rake routes"
ActionController::Routing::Routes.draw do |map|
  map.resources :users, :collection => { :autocomplete_town => :post }
  map.resource :session
  map.logout    '/logout', :controller => 'sessions', :action => 'destroy'

  map.resources :ideas, :as => 'ideen', :member => {:vote_up => :post, :vote_down => :post } do |ideas|
    ideas.resources :comments
  end
  
  map.resources :comments

  map.resources :tasks, :as => 'projekte', :member => {:contribute => :post} do |tasks|
    tasks.resources :comments
  end

  # ADMIN
  map.admin '/admin', :controller => 'admin/events', :action => 'adminindex'
  map.resources :events, :controller => 'admin/events', :path_prefix => "/admin"
  map.resources :candidates, :controller => 'admin/candidates', :path_prefix => "/admin"
  #map.administer_events '/events', :controller => 'admin/events', :path_prefix => "/admin", :action => 'index'
  
  map.event_list '/treffen', :controller => 'events', :action => 'index'

  map.video '/warum', :controller => 'videos', :action => 'index'
  map.video_record '/warum/ich', :controller => 'videos', :action => 'record'
  map.video_show '/warum/:id', :controller => 'videos', :action => 'play'

  map.connect '/in/:name', :controller => 'geo', :action => 'local'
  map.root :controller => "geo"

  map.elsewhere '/web', :controller => 'elsewhere', :action => 'index'
  
  map.deleteme '/deleteme', :controller => 'users', :action => 'deleteme'
  
  map.about '/ueber', :controller => 'static', :action => 'about'
  
  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  map.connect '*path', :controller => 'static'
end
