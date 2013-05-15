require 'rvm/capistrano'
set :whenever_environment, 'production'
require 'bundler/capistrano'

server "94.23.143.149", :web, :app, :db, primary: true

set :user, "philippeguegan"
set :deploy_to, "/home/#{user}/www/#{application_folder}"
set :rails_env, "production"

set :branch, "master"

set :rvm_type, :user
set :rvm_ruby_string, "ruby-1.9.3-p392"
set :bundle_dir, "/home/#{user}/.rvm/gems/ruby-1.9.3-p392"

namespace :deploy do
  desc "Start the Thin processes"
  task :start do
    run "cd #{current_path} && bundle exec thin start -C config/thin.yml"
  end
  desc "Stop the Thin processes"
  task :stop do
    run "cd #{current_path} && bundle exec thin stop -C config/thin.yml"
  end
  desc "Restart the Thin processes"
  task :restart do
    run "cd #{current_path} && bundle exec thin restart -C config/thin.yml"
  end
end