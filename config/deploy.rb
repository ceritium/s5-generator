
#############################################################
#	Application
#############################################################

set :application, "s5"
set :deploy_to, "/var/www/#{application}"

#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:paranoid] = false
ssh_options[:port] = 22
set :scm_verbose, true 
set :keep_releases, 2

#############################################################
#	Servers
#############################################################

set :user, "ceritium"
set :domain, "ceritium.no-ip.org"
server domain, :app, :web
role :db, domain, :primary => true

#############################################################
#	Git
#############################################################

set :scm, :git
set :branch, "master"
set :scm_user, 'git'
set :repository,  'git://github.com/ceritium/s5-generator.git'
set :deploy_via, :remote_cache

#############################################################
#	database.yml generation
#############################################################

require 'erb'

  before "deploy:setup", :db
  after "deploy:update_code", "db:symlink"

  namespace :db do
    desc "Create database yaml in shared path"
    task :default do
      db_config = ERB.new <<-EOF
      base: &base
        adapter: mysql
        username: root
        password:
        encoding: utf8
        socket: /var/run/mysqld/mysqld.sock

      development:
        database: #{application}_development
        <<: *base

      production:
        database: #{application}_production
        <<: *base
      EOF

      run "mkdir -p #{shared_path}/config"
      put db_config.result, "#{shared_path}/config/database.yml"
    end

    desc "Make symlink for database yaml, mongrel cluster"
    task :symlink do     
      run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"      
      
    end   
  end


#############################################################
#	Passenger
#############################################################

namespace :deploy do
  
  # Restart passenger on deploy
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
end
