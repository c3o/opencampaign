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
role :db, "test.arminsoyka.at"

#after  "deploy:finalize_update" do
##  run "ln -nfs #{shared_path}/portraits #{current_path}/public/portraits"
#end
after "deploy:finalize_update", "symlinks" #deploy:set_rails_env"

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
  
  desc "set ENV['RAILS_ENV'] for mod_rails (phusion passenger)"
  task :set_rails_env do
    tmp = "#{current_release}/tmp/environment.rb"
    final = "#{current_release}/config/environment.rb"
    run <<-CMD
      echo 'RAILS_ENV = "production"' > #{tmp};
      cat #{final} >> #{tmp} && mv #{tmp} #{final};
    CMD
  end

end

desc "Symlink everything from shared/config to release/config"
task :symlinks, :except => { :no_release => true }  do
  run <<-CMD 
    cd #{shared_path}/config ;
    for i in $( ls *.yml); do 
      ln -fs #{shared_path}/config/$i #{current_path}/config/$i;
    done
  CMD
  ##run "ln -nfs #{current_path}/public/images/presse #{shared_path}/presse"
end