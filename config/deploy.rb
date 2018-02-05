require 'mina/git'

set :domain, '37.139.12.234'
set :user, 'foxweb'
set :deploy_to, '/home/foxweb/www/kurepin.com'
set :repository, 'git@github.com:foxweb/kurepin.com.git'
set :branch, 'master'
set :shared_paths, %w[public/pub public/photo public/vk]
set :keep_releases, 5

task setup: :environment do
  queue! %(mkdir -p "#{deploy_to}/shared/public/pub")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/shared/public/pub")

  queue! %(mkdir -p "#{deploy_to}/shared/public/photo")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/shared/public/photo")

  queue! %(mkdir -p "#{deploy_to}/shared/public/vk")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/shared/public/vk")
end

desc 'Deploys the current version to the server.'
task deploy: :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'deploy:cleanup'

    to :launch do
      # nothing
    end
  end
end
