# Gemfile
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.6'  

# Core Rails
gem 'rails', '~> 6.1.7'
gem 'pg', '~> 1.1'  

gem 'logger'
# Asset pipeline
gem 'cssbundling-rails'
gem 'jbuilder', '~> 2.7'
gem 'turbolinks', '~> 5'

# AWS S3
gem 'aws-sdk-s3', require: false
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
  
  # Capistrano deployment
  gem 'capistrano', '~> 3.17'
  gem 'capistrano-rails', '~> 1.6'
  gem 'capistrano-bundler', '~> 2.0'
  gem 'capistrano-rbenv', '~> 2.2'
  gem 'capistrano3-unicorn'  # For deploying Unicorn on server
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  gem 'webdrivers'
end

group :production do
  gem 'unicorn'  # Only for Linux production server
end

# Windows-specific
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]