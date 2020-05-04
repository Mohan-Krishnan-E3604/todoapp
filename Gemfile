source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.11.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# rails-api application
gem 'rails-api'
gem 'active_model_serializers', '~> 0.10.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Rails i18n
gem 'rails-i18n', github: 'svenfuchs/rails-i18n', branch: 'rails-4-x'
# Sidekiq for async works
gem 'sidekiq'
# SendGrid action mailer
gem 'sendgrid-actionmailer'
gem 'redis'
gem 'jwt'
# Elastic search add on
gem 'searchkick'
gem 'apiblueprint-rails'
gem 'rack-cors'
# gem for convert json response keys to camelCase
gem 'snaky_camel'

# security scanner
gem 'brakeman'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

group :test do
  gem 'factory_bot_rails', '~> 4.0'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'faker'
  gem 'database_cleaner'
  gem 'simplecov'
  gem 'mock_redis'
  gem 'rspec-sidekiq'
  gem 'elasticsearch-extensions'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
