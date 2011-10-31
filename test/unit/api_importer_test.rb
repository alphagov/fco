require 'test_helper'

class APIImporterTest < ActiveSupport::TestCase

  setup do
    stub_request(:get, "http://fco.innovate.direct.gov.uk/countries.json").
      to_return(:body => File.new(asset_path('countries.json')))
  end

  test '.run' do
    APIImporter.new.run
    assert_equal 222, Country.count
  end

end
