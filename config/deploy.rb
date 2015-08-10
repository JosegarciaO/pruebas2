set :user, "capistrano"
set :runner, "capistrano"
set :use_sudo, false
set :git_repository, "gitlab.agilekoding.com"

set :stages, %w(staging production)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

# Load RVM's capistrano plugin.
require "rvm/capistrano"
require "bundler/capistrano"

set :rvm_ruby_string, '1.9.3@orbe-certificados'
set :rvm_type, :user  # Don't use system-wide RVM

# Keep only 3 depoyed releases
set :keep_releases, 3

# Git configuration
# set :deploy_via, :remote_cache
set :scm, :git
set :repository, "git@#{git_repository}:orbe-seguros/certificados-para-transportistas.git"
default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# Task
namespace :deploy do

  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  desc "Compile all the assets named in config.assets.precompile."
  task :precompile_assets do
    raise "Rails environment not set" unless rails_env
    task = "assets:precompile"
    run "cd #{release_path} && bundle exec rake #{task} RAILS_ENV=#{rails_env}"
  end
  # desc "Install gems"
  # task :bundle_install do
  #   raise "Rails environment not set" unless rails_env
  #   run "cd #{release_path} && bundle install --without development test"
  # end

end

# Callbacks
after "deploy:update_code", "deploy:symlink_shared" #, "deploy:precompile_assets"