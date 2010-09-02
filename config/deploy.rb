require 'mongrel_cluster/recipes'
require 'lib/recipes/capistrano_database'

ssh_options[:port] = 20001
default_run_options[:pty] = true
set :application, "myblog"
set :scm, "git"
set :repository,  "git@github.com:dparoulek/myblog.git"
set :user, "dparoulek"

set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_to, "/var/rails/myblog"

role :web, "hokies"                          # Your HTTP server, Apache/etc
role :app, "jackets"                          # This may be the same as your `Web` server
role :db,  "jackets", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

task :move_static_files, :roles => :web do
  desc "Starting moving the static public files to Apache Document Root."
  upload("/var/rails/#{application}/public", "/home/myblogadmin/", :via => :scp, :recursive => true)
  desc "Ending moving the static public files to Apache Document Root."
end
