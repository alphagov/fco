ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock/test_unit'
require 'asset_helpers'

class ActiveSupport::TestCase
  include AssetHelpers
end
