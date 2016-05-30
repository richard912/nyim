require "rvm/capistrano"

set :rvm_ruby_string, :local              # use the same ruby as used locally for deployment
set :rails_env, 'production'

before 'deploy:setup', 'rvm:install_rvm'  # install RVM
before 'deploy:setup', 'rvm:install_ruby' # install Ruby and create gemset, OR:
set :rvm_install_type, :stable

require './config/boot'
require 'airbrake/capistrano'
require 'delayed/recipes'

# bundler bootstrap
#http://github.com/carlhuda/bundler/blob/master/lib/bundler/capistrano.rb
require 'bundler/capistrano'

#https://github.com/capistrano/capistrano/wiki/2.x-Multistage-Extension
set :stages, %w(linode hostv oldhostv)
set :default_stage, "hostv"
require 'capistrano/ext/multistage'

# server details
default_run_options[:pty] = true

# main details
set :application, "nyim"

# repo details
set :deploy_via, :remote_cache
set :scm, :git
set :repository, "git@github.com:3rdI/nyim.git"
#cap -S branch=develop deploy
set :branch, fetch(:branch, 'master')

#https://github.com/capistrano/capistrano/issues/79
set :normalize_asset_timestamps, false

# tasks
set(:system_files_path) { "#{release_path}/config/deploy/#{stage}" }
set(:crontab_path) { "#{system_files_path}/crontab" }

set :delayed_job_args, "-n 3"

# shared tasks
namespace :crontab do
  desc "install crontab"
  task :install do
    sudo "crontab -u #{user} #{crontab_path}"
  end
end

after "deploy:start", "crontab:install"
after "deploy:restart", "crontab:install"

namespace :shared do
  desc "link to legacy assets"
  task :legacy do
    run "ln -sf #{shared_path}/legacy #{current_path}/public/legacy"
  end
end

namespace :deploy do
  desc "link config files"
  task :symlink_config, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/application.yml #{release_path}/config/application.yml"
  end
end

after "deploy:start", "shared:legacy"
after "deploy:restart", "shared:legacy"
after "deploy:start", "deploy:symlink_config"
after "deploy:restart", "deploy:symlink_config"

after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start"
after "deploy:restart", "delayed_job:restart"

