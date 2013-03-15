require 'bundler/capistrano'

server "ssh.alwaysdata.com", :web, :app, :db, primary: true

set :user, "alouatta"
set :deploy_to, "/home/#{user}/#{application_folder}"
set :rails_env, "production"

set :branch, "master"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end
  task :seed do
    run "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
  end
  task :reset do
    run "cd #{current_path}; rake db:reset RAILS_ENV=#{rails_env}"
  end
end