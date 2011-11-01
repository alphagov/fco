require 'test_helper'

class APIImporterTest < ActiveSupport::TestCase

  test '.import_countries' do
    stub_request(:get, "http://fco.innovate.direct.gov.uk/countries.json").
      to_return(:body => File.new(asset_path('countries.json')))

    APIImporter.new.import_countries
    assert_equal 222, Country.count
  end

  test '.import_missions' do
    stub_request(:get, "http://fco.innovate.direct.gov.uk/embassies.json").
      to_return(:body => File.new(asset_path('embassies.json')))

    APIImporter.new.import_missions
    assert_equal 425, Mission.count
  end

  test '.import_travel_advice' do
    stub_request(:get, "http://fco.innovate.direct.gov.uk/travel-advice/full_results.json?c%5B%5D=afghanistan").
      to_return(:body => File.new(asset_path('travel_advice_afghanistan.json')))
    country = Country.create!(:name => "Afghanistan", :fco_id => "afghanistan", :iso_3166_2 => "AF", :slug => "afghanistan")

    APIImporter.new.import_travel_advice

    country.reload
    assert_equal 7, country.raw_travel_advice['travel_advice_sections'].length
  end

  test '.import_travel_news' do
    stub_request(:get, "http://fco.innovate.direct.gov.uk/travel-news.json").
      to_return(:body => File.new(asset_path('travel-news.json')))

    APIImporter.new.import_travel_news
    assert_equal 10, TravelNews.count
  end

end
