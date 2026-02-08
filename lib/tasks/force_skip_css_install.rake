# lib/tasks/force_skip_css_install.rake
if Rails.env.production?
  Rake::Task['css:install'].enhance do
    puts "Forcing skip of cssbundling-rails yarn install in production"
    # Clear the install dependency so it doesn't run
    Rake::Task['css:install'].prerequisites.clear
  end
end