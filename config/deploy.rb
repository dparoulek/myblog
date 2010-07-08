require 'mongrel_cluster/recipes'

ssh_options[:port] = 20001
default_run_options[:pty] = true
set :application, "myblog"
set :scm, "git"
set :repository,  "git@github.com:dparoulek/myblog.git"
set :user, "dparoulek"

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :branch, "master"
set :deploy_via, :remote_cache

set :deploy_to, "/var/rails/myblog"

role :web, "jackets"                          # Your HTTP server, Apache/etc
role :app, "jackets"                          # This may be the same as your `Web` server
role :db,  "jackets", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# ensure this is set after :deploy_to
# set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
