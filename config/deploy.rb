set :application, 'abcde'
set :repo_url, 'git@github.com:vs-adm/abcde.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/home/rails/projects/abcde'
# set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do

  unicorn_conf = "#{deploy_to}/current/config/unicorn.rb"
  unicorn_pid = "#{deploy_to}/shared/pids/unicorn.pid"

  unicorn_start_cmd = "(cd #{deploy_to}/current; /usr/local/rvm/bin/rvm use 1.9.3 do bundle exec unicorn_rails -E production -Dc #{unicorn_conf})"

  desc "Start application"
  task :start do
    on roles(:app) do
      execute unicorn_start_cmd
    end
  end

  desc "Stop application"
  task :stop do
    on roles(:app) do
      execute "[ -f #{unicorn_pid} ] && kill -QUIT `cat #{unicorn_pid}`"
    end
  end

  desc "Restart Application"
  task :restart do
    on roles(:app) do
      execute "[ -f #{unicorn_pid} ] && kill -USR2 `cat #{unicorn_pid}` || #{unicorn_start_cmd}"
    end
  end

  after :finishing, 'deploy:cleanup'

end
