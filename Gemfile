source 'http://rubygems.org'

gem 'rails', '3.1.1'
gem 'mysql2'
gem 'jquery-rails'
gem 'rest-client'
gem 'stringex'
gem 'loofah'
gem 'nokogiri'

if ENV['SLIMMER_DEV']
  gem 'slimmer', :path => '../slimmer'
else
  gem 'slimmer', :git => 'git@github.com:alphagov/slimmer.git'
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
