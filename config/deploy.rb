lock "~> 3.20.0"

set :application, 'cdp_web_web_aws_deploy_task'
set :repo_url,    'https://github.com/Fanon-hub/cdp_web_web_aws_deploy_task.git'
set :branch,      'master'   # or 'main' if that's your default branch

set :deploy_to,   '/home/ec2-user/cdp_web_web_aws_deploy_task'

# rbenv (user install on EC2)
set :rbenv_type, :user
set :rbenv_ruby, '3.1.6'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake rails ruby bundle}

# Linked files/dirs (shared across releases)
set :linked_files, %w{config/database.yml config/master.key}
set :linked_dirs,  %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/packs}

# Unicorn integration
set :unicorn_roles, [:app]
set :unicorn_config_path, -> { "#{shared_path}/config/unicorn.rb" }
set :unicorn_pid,     -> { "#{shared_path}/tmp/pids/unicorn.pid" }
set :unicorn_env,     -> { fetch(:rails_env, 'production') }

# General
set :keep_releases, 5
set :format,        :airbrussh
set :log_level,     :info
set :pty,           true
set :use_sudo,      false


# Load production ENV vars from shared .env.production (if exists)
set :default_env, -> {
  env = {}
  on roles(:app) do
    within shared_path do
      if test :test, "-f config/.env.production"
        capture(:cat, "config/.env.production").lines.each do |line|
          line.strip!
          next if line.empty? || line.start_with?('#')
          key, *value_parts = line.split('=', 2)
          value = value_parts.join('=') if value_parts.any?
          env[key] = value.strip if key && value
        end
      end
    end
  end
  env
}

set :ssh_options, {
  keys: %w(C:/Users/DELL/Downloads/Ruby-assign.pem),   
  forward_agent: false,
  auth_methods: %w(publickey),
  user: 'ec2-user',
  port: 22   
}
