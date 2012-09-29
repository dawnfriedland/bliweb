set :application, "bliweb"
set :domain, "75.147.182.89" 
set :repository,  "git@github.com:dawnfriedland/bliweb.git"
set :use_sudo,    false
set :deploy_to, "/home/www-publisher/www/bliweb" 
set :scm,         "git"
set :user,        "www-publisher"

role :app, domain
role :web, domain
role :db,  domain, :primary => true

require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_type, :system
set :rvm_ruby_string, '1.9.3@bliweb'        # Or whatever env you want it to run in.

namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{current_release}"
  end
end

namespace :links do
  task :generate_symbolic_links, :roles => :app do
    run "cd #{current_release} && ln -s /home/www-publisher/www/bliweb/shared/logs logs"
  end
end

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end

after "deploy", "rvm:trust_rvmrc"
#after "deploy", "links:generate_symbolic_links"
