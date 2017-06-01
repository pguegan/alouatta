require 'bundler/capistrano'
require 'capistrano/ext/multistage'

load 'config/recipes/template'

set :stages, %w(production staging)
set :default_stage, "staging"

set :application, "alouatta"
set :port,                  22
set(:deploy_to)             { "/home/#{user}/www" }
set :deploy_via,            :remote_cache
set :use_sudo,              false

set :scm,                   :git
set :scm_verbose,           true
set :repository,            "git@github.com:pguegan/alouatta.git"
set :git_enable_submodules, 1

set(:unicorn_pid)           { "#{shared_path}/pids/unicorn.pid" }
set(:unicorn_conf)          { "#{current_path}/config/unicorn.rb" }

set :assets_dir,            "public/uploads"

set :keep_releases,         3

default_run_options[:pty]   = true
ssh_options[:forward_agent] = true

after 'deploy',                    'deploy:cleanup'
after 'deploy:finalize_update',    'deploy:link_configuration'
after 'deploy:finalize_update',    'deploy:link_uploads'
after 'deploy:link_configuration', 'deploy:migrate'
after 'deploy:setup',              'deploy:setup_configuration'

namespace :deploy do

  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "if [ -f #{unicorn_pid} ]; then kill `cat #{unicorn_pid}`; fi"
  end
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "if [ -f #{unicorn_pid} ]; then kill -s QUIT `cat #{unicorn_pid}`; fi"
  end
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "if [ -f #{unicorn_pid} ]; then kill -s USR2 `cat #{unicorn_pid}`; else cd #{current_path} && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end
  task :restart do
    deploy.stop
    deploy.start
  end

  task :setup_configuration, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template "nginx.conf", "#{shared_path}/config/nginx.conf"
    #sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}_#{rails_env}"
    template "unicorn.sh", "#{shared_path}/config/unicorn.sh"
    #sudo "ln -nfs #{current_path}/config/unicorn.sh /etc/init.d/unicorn_#{application}_#{rails_env}"
    run "chmod +x #{shared_path}/config/unicorn.sh"
    template "unicorn.rb", "#{shared_path}/config/unicorn.rb"
    template "database.yml", "#{shared_path}/config/database.yml", password: Capistrano::CLI.password_prompt("Password for database (#{application}_#{rails_env}): ")
    run "mkdir -p #{shared_path}/uploads"
    run "mkdir -p #{shared_path}/private"
  end

  task :link_configuration, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/nginx.conf #{release_path}/config/nginx.conf"
    run "ln -nfs #{shared_path}/config/unicorn.rb #{release_path}/config/unicorn.rb"
    run "ln -nfs #{shared_path}/config/unicorn.sh #{release_path}/config/unicorn.sh"
  end

  task :link_uploads do
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
    run "ln -nfs #{shared_path}/private #{release_path}/private/uploads"
  end

end

require './config/boot'