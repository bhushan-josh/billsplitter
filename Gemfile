# frozen_string_literal: true

source 'https://rubygems.org'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.2.2', '>= 7.2.2.1'

# Use sqlite3 as the database for Active Record
gem 'sqlite3', '>= 1.4'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use to analyze and format Ruby code
gem 'rubocop', '~> 1.71', require: false

# Use for versioning Rails-based RESTful APIs
gem 'versionist'

# I18n translate Ruby applications into multiple languages
gem 'i18n', '~> 1.14', '>= 1.14.7'

# JWT gem is used to securely exchange information between parties, and for user authentication and authorization
gem 'jwt'

# Automatically generate API documentation from RSpec
gem 'rspec_api_documentation', '~> 6.1'

gem 'rspec-rails'

# Implement user authentication features within a web application
gem 'devise'

# Use to manage authorization in Ruby on Rails applications
gem 'pundit', '~> 2.4'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

gem 'rack-cors'

gem 'active_model_serializers'

gem 'dotenv-rails'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem 'brakeman', require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem 'rubocop-rails-omakase', require: false

  # Byebug is a simple to use and feature rich debugger for Ruby
  gem 'byebug', '~> 11.1'

  # SimpleCov is a code coverage analysis tool for Ruby
  gem 'simplecov', require: false, group: :test
end

