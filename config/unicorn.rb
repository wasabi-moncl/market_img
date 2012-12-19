root = "/home/moncl/market_img/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn_stderr.log"
stdout_path "#{root}/log/unicorn_stdout.log"

listen 80
listen "/tmp/unicorn.market_img.sock"

worker_processes 2
timeout 30

before_exec do |server| 
  ENV["BUNDLE_GEMFILE"] = "/market_img/current/Gemfile" 
end