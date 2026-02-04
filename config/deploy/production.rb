# config/deploy/production.rb - Local only

role :app, %w{localhost}
role :web, %w{localhost}
role :db,  %w{localhost}, primary: true

set :ssh_options, {}          # empty hash - no SSH
set :pty, false
set :use_sudo, false

# rbenv local
set :rbenv_ruby, '3.1.6'
set :rbenv_type, :user
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake rails ruby bundle}