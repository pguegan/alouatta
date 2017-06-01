set :rails_env,           "production"
set :branch,              ENV['GIT_BRANCH'] || "1.0-stable"
set :user,                "alouatta_production"
set :default_environment, { 'PATH' => "/home/#{user}/.rbenv/shims:/home/#{user}/.rbenv/bin:$PATH" }

server                    "37.187.135.154", :web, :app, :db, primary: true