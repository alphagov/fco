source 'http://rubygems.org'

gem 'rails', '3.1.1'
gem 'mysql2'
gem 'jquery-rails'
gem 'rest-client'
gem 'stringex'

group :development do
  gem 'guard'
  gem 'guard-test'

  if RUBY_PLATFORM =~ /darwin/i
    gem 'growl_notify'
    gem 'rb-fsevent'
  end
end

group :test do
  gem 'turn', :require => false
  gem 'webmock'
  gem 'minitest'
end
