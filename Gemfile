source 'https://rubygems.org'

ruby '3.2.2'

gem 'aws-sdk', '~> 3'
gem 'cancancan', '~> 3.5'
gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.2'
gem 'rswag', '~> 2.4'
gem 'rswag-api', '~> 2.13'
gem 'rswag-ui', '~> 2.5', '>= 2.5.1'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '>= 4.0.1'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem 'kredis'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem 'image_processing', '~> 1.2'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
# gem 'rack-cors'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[ mri windows ]
  gem 'devise', '~> 4.9', '>= 4.9.3'
  gem 'doorkeeper', '~> 5.6', '>= 5.6.8'
  gem 'factory_bot_rails', '~> 6.4', '>= 6.4.3'
  gem 'faker', '~> 3.2', '>= 3.2.3'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rspec-rails', '~> 6.0', '>= 6.0.3'
  gem 'rubocop', '~> 1.60', require: false
  gem 'rubocop-rails', '~> 2.23', '>= 2.23.1'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem 'spring'
end

group :test do
  gem 'shoulda-matchers', '~> 6.0'
end
