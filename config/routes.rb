# See how all your routes lay out with "rake routes"
ActionController::Routing::Routes.draw do |map|
  map.resources :users, :collection => { :autocomplete_town => :post }
  map.resource :session
  map.logout    '/logout', :controller => 'sessions', :action => 'destroy'

  map.connect '/check_fb_user', :controller => 'users', :action => 'check_fb_user'

  map.resources :ideas, :as => 'ideen', :member => {:vote_up => :post, :vote_down => :post } do |ideas|
    ideas.resources :comments
  end

  map.resources :questions, :as => 'fragen', :member => {:contribute => :post} do |questions|
    questions.resources :comments
  end

  map.resources :tasks
  
  map.resources :comments

  map.projectpage '/projekte/:slug', :controller => 'projects', :action => 'show', :requirements => { :slug => /[A-Za-z0-9_-]+/ }
  map.taskpage '/projekte/:slug/tasks/:id', :controller => 'tasks', :action => 'show', :requirements => { :slug => /[A-Za-z0-9_-]+/ }
  map.resources :projects, :as => 'projekte', :member => {:contribute => :post} do |projects|
    projects.resources :comments
    projects.resources :tasks
  end

  #map.resources :tasks, :as => 'tasks', :member => {:contribute => :post} do |tasks|
  #  tasks.resources :comments
  #end

  #####map.resources :events, :as => 'events2'

  # ADMIN
  map.admin '/admin', :controller => 'admin/events', :action => 'adminindex'
  map.resources :events, :controller => 'admin/events', :path_prefix => "/admin"
  map.resources :adminquestions, :controller => 'admin/questions', :path_prefix => "/admin"
  map.resources :adminprojects, :controller => 'admin/projects', :path_prefix => "/admin"
  map.resources :pages, :controller => 'admin/pages', :path_prefix => "/admin"
  map.resources :candidates, :controller => 'admin/candidates', :path_prefix => "/admin"
  map.resources :adminusers, :controller => 'admin/users', :path_prefix => "/admin"
  
  map.event_list '/termine', :controller => 'events', :action => 'index'
  map.task_list '/tasks', :controller => 'tasks', :action => 'index'
  map.question_list '/fragen', :controller => 'questions', :action => 'index'
  #map.profile_list '/users', :controller => 'users', :action => 'index'
  map.projects_more '/forderungen', :controller => 'projects', :action => 'index', :is_active => false

  map.video '/warum', :controller => 'videos', :action => 'index'
  map.video_record '/warum/ich', :controller => 'videos', :action => 'record'
  map.video_show '/warum/:id', :controller => 'videos', :action => 'play'

  map.connect '/in/:name', :controller => 'geo', :action => 'local'
  map.participate '/mitmachen', :controller => 'geo', :action => 'index'
  
  map.root :controller => 'static' #, :action => 'about'
  #map.about '/armin', :controller => 'static' #, :action => 'about'

  map.elsewhere '/web', :controller => 'elsewhere', :action => 'index'
  
  map.deleteme '/deleteme', :controller => 'users', :action => 'deleteme'
  
  
  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  # Armin Soyka legacy
  map.connect '/:legacy', :requirements => { :legacy => /(blog|wiki|joomla|cv).*/ }, :controller => 'redirect', :action => 'index'

  map.connect '*path', :controller => 'static'
end
