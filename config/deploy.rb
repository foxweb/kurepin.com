require 'mina/git'

set :domain, '37.139.12.234'
set :user, 'foxweb'
set :deploy_to, '/home/foxweb/www/kurepin.com'
set :repository, 'git@github.com:foxweb/kurepin.com.git'
set :branch, 'master'

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke :'git:clone'
  end
end
