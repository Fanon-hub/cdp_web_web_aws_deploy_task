# unicorn configuration for production environment
# see https://github.com/defunkt/unicorn for options

worker_processes Integer(ENV['WEB_CONCURRENCY'] || 2)
preload_app true

# listen on a unix socket so nginx can proxy_pass
listen ENV.fetch('UNICORN_SOCKET') { '/tmp/unicorn.sock' }, backlog: 64

working_directory ENV.fetch('UNICORN_WORKING_DIR') { File.expand_path('..', __dir__) }

pid ENV.fetch('UNICORN_PID') { '/tmp/unicorn.pid' }

stderr_path ENV.fetch('UNICORN_LOG_DIR') { File.expand_path('log/unicorn.stderr.log', __dir__) }
stdout_path ENV.fetch('UNICORN_LOG_DIR') { File.expand_path('log/unicorn.stdout.log', __dir__) }

# gracefully restart workers on deploy
before_fork do |server, worker|
  old_pid = server.config[:pid].sub(/\.pid$/, '.oldbin')
  if old_pid != server.pid && File.exist?(old_pid)
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # nothing
    end
  end
end

# allow ActiveRecord connection re-establish on worker boot
after_fork do |server, worker|
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end
