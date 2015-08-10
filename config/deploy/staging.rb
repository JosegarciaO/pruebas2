set :rvm_ruby_string, 'ruby-1.9.3@orbe-certificados'
set :user, "capistrano"
set :runner, "capistrano"

set :domain, "staging.orbe-certificados.agilekoding.com"
puts "*** Deploying to \033[1;42m  STAGING \033[0m !"
set :application, "staging.orbe-certificados.agilekoding.com"
set :rails_env, "staging"
set :branch, "development"
set :deploy_to, "/srv/www/htdocs/apps/#{application}"

role :app, domain
role :web, domain
role :db,  domain, :primary => true