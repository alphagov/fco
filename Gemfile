source 'http://rubygems.org'
source 'https://gems.gemfury.com/vo6ZrmjBQu5szyywDszE/'

group :router do
  gem 'router-client', '2.0.3', :require => 'router/client'
end

group :passenger_compatibility do
  gem 'rack', '1.3.5'
  gem 'rake', '0.9.2'
end

gem 'rails', '3.1.1'
gem 'mysql2'
gem 'jquery-rails'
gem 'rest-client'
gem 'stringex'
gem 'loofah'
gem 'nokogiri'
gem 'whenever'

gem 'plek', '~> 0'

gem 'aws-ses', :require => 'aws/ses'
gem 'rummageable', :git => 'git@github.com:alphagov/rummageable.git'
gem 'exception_notification'

if ENV['SLIMMER_DEV']
  gem 'slimmer', :path => '../slimmer'
else
  gem 'slimmer', '~> 1.1'
end

group :development do
  gem 'guard'
  gem 'guard-minitest'
end

group :test do
  gem 'sqlite3-ruby', :require => false
  gem 'turn', :require => false
  gem 'webmock', :require => false
  gem 'mocha', :require => false
  gem 'minitest'
  gem 'simplecov', '0.4.2'
  gem 'simplecov-rcov'
  gem 'ci_reporter'
end
