require "bundler/capistrano"

set :application, "market_img"

# Setup for SCM(Git)
set :scm, :git
set :repository, "git@github.com:wasabi-moncl/market_img.git"
set :branch, "master"

role :web, "book.moncl.net"     # Your HTTP server, Apache/etc
role :app, "book.moncl.net"     # This may be the same as your `Web` server
role :db,  "book.moncl.net", :primary => true # This is where Rails migrations will run
set :user, "moncl"
set :use_sudo, false

set :deploy_to, "/home/#{user}/#{application}"
set :deploy_via, :remote_cache

set :default_environment, { "PATH" =>
"$HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/.rbenv/versions/1.9.3-p286/bin:$HOME/.rbenv/versions/1.9.3-p286/lib/ruby/gems/1.9.1/gems:$PATH"
}

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup"

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    # put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  desc "expand the gems"
  task :gems, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path}; #{shared_path}/bin/bundle unlock"
    run "cd #{current_path}; nice -19 #{shared_path}/bin/bundle install vendor/" # nice -19 is very important otherwise DH will kill the process!
    run "cd #{current_path}; #{shared_path}/bin/bundle lock"
  end
    
  desc "Symlink shared configs and folders on each release."
  task :create_symlink_shared do
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
    # run "ln -nfs #{shared_path}/config/mongoid.yml #{release_path}/config/mongoid.yml"
    # run "ln -nfs #{shared_path}/config/apikey.yml #{release_path}/config/apikey.yml"
  end
  after 'deploy:create_symlink', 'deploy:create_symlink_shared'

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end