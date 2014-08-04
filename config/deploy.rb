set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :application, "alouatta"
set :application_folder, "alouatta"
set :git_repository, "alouatta"

set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
#set :repository, "philippe.guegan@nas.decam.fr:#{git_repository}.git"
set :repository, "git@github.com:pguegan/#{git_repository}.git"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :keep_releases, 4
set :git_enable_submodules, 1

after "deploy", "deploy:cleanup"