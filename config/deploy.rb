require 'mina/git'

set :domain, '37.139.12.234'
set :user, 'foxweb'
set :deploy_to, '/home/foxweb/www/kurepin.com'
set :repository, 'git@github.com:foxweb/kurepin.com.git'
set :branch, 'master'

task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/content/pub"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/content/pub"]
  
  queue! %[mkdir -p "#{deploy_to}/shared/content/photo"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/content/photo"]
  
  queue! %[mkdir -p "#{deploy_to}/shared/content/vk"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/content/vk"]
end


desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke :'git:clone'

    to :launch do
      queue! %[ln -nfs #{deploy_to}/shared/content/pub #{deploy_to}/#{current_path}/public/pub]
      queue! %[ln -nfs #{deploy_to}/shared/content/photo #{deploy_to}/#{current_path}/public/photo]
      queue! %[ln -nfs #{deploy_to}/shared/content/vk #{deploy_to}/#{current_path}/public/vk]
    end
  end
end
