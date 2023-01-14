# frozen_string_literal: true

require 'mina/git'
require 'mina/rbenv'
require 'mina/deploy'

set :application_name, 'kurepin.com'
set :domain, 'kurepin.com'
set :deploy_to, '/home/foxweb/www/kurepin.com'
set :repository, 'git@github.com:foxweb/kurepin.com.git'
set :branch, 'master'
set :shared_paths, %w[public/pub public/photo public/vk public/.well-known]
set :user, 'foxweb'

# Shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# Some plugins already add folders to shared_dirs like `mina/rails` add `public/assets`, `vendor/bundle` and many more
# run `mina -d` to see all folders and files already included in `shared_dirs` and `shared_files`
set :shared_dirs, fetch(:shared_dirs, []).push(*%w[public/pub public/photo public/vk public/.well-known])
# set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml')

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :remote_environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use', 'ruby-2.5.3@default'
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  # command %{rbenv install 2.5.3 --skip-existing}
  # command %{rvm install ruby-2.5.3}
  # command %{gem install bundler}
end

desc 'Deploys the current version to the server.'
task :deploy do
  invoke :'git:ensure_pushed'

  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'deploy:cleanup'

    on :launch do
      # nothing
    end
  end
end
