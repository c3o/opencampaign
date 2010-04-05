set :application, "opencampaign"
set :repository,  "git@github.com:c3o/opencampaign.git"

set :user, "app"

set :scm, :git
set :scm_username, "c3o"
set :git_enable_submodules, 1
set :user, 'arminsoyka'
set :deploy_to, "/home/arminsoyka/test.arminsoyka.at/#{application}"
set :use_sudo, false
set :deploy_via, :copy

role :app, "test.arminsoyka.at"
role :web, "test.arminsoyka.at"

after  "deploy:finalize_update" do
##  run "ln -nfs #{shared_path}/uploads #{current_path}/public/images/uploads"
##  run "ln -nfs #{shared_path}/portraits #{current_path}/public/portraits"
end

# mod_rails (phusion_passenger) stuff
namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end 
  
  [:start, :stop].each do |t|
    desc "start/stop is not necessary with mod_rails"
    task t, :roles => :app do 
      # nothing
    end
  end
end