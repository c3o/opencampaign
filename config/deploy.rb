set :application, "lif"
set :repository,  "git+ssh://lifdev@dev.ext.soup.io/home/lifdev/git/lif"

set :user, "app"

set :scm, :git
set :scm_username, "lifdev"
set :git_enable_submodules, 1
set :deploy_via, :remote_cache
ssh_options[:forward_agent] = true

role :app, "diesmal-lif.at"
role :web, "diesmal-lif.at"
role :db,  "diesmal-lif.at", :primary => true

after  "deploy:finalize_update" do
  run "ln -nfs #{shared_path}/uploads #{current_path}/public/images/uploads"
  run "ln -nfs #{shared_path}/portraits #{current_path}/public/portraits"
end