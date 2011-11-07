require 'test_helper'

class APIImporterTest < ActiveSupport::TestCase

  test '.import_countries' do
    stub_request(:get, "http://fco.innovate.direct.gov.uk/countries.json").
      to_return(:body => File.new(asset_path('countries.json')))

    APIImporter.new.import_countries
    assert_equal 222, Country.count
    assert_equal 425, Mission.count
  end

  test '.import_travel_advice' do
    stub_request(:get, "http://fco.innovate.direct.gov.uk/travel-advice/full_results.json?c%5B%5D=afghanistan").
      to_return(:body => File.new(asset_path('travel_advice_afghanistan.json')))
    country = Country.create!(:name => "Afghanistan", :fco_id => "afghanistan", :iso_3166_1 => "AF", :slug => "afghanistan")

    APIImporter.new.import_travel_advice

    country.reload
    assert_equal 7, country.raw_travel_advice['travel_advice_sections'].length
  end

  test '.import_travel_news' do
    stub_request(:get, "http://fco.innovate.direct.gov.uk/travel-news.json").
      to_return(:body => File.new(asset_path('travel_news.json')))

    APIImporter.new.import_travel_news
    assert_equal 10, TravelNews.count
  end

  test '.import_country_advice' do
    stub_request(:get, "http://fco.innovate.direct.gov.uk/countries.json").
      to_return(:body => File.new(asset_path('countries.json')))

    APIImporter.new.import_countries
    assert_equal 222, Country.count

    stub_request(:get, "http://www.fco.gov.uk/en/travel-and-living-abroad/travel-advice-by-country?action=noTravelAll").
      to_return(:body => File.new(asset_path('travel_advice_by_country.html')))

    APIImporter.new.import_advice_statuses
    assert_equal :parts, Country.find_by_iso_3166_1!("AF").essential_travel_restriction
    assert_equal :parts, Country.find_by_iso_3166_1!("AF").avoid_travel_restriction
  end

  test '.import_country_metadata' do
    country = Country.create!(:name => "United Kingdom", :fco_id => "united-kingdom", :iso_3166_1 => "GB", :slug => "united-kingdom")

    stub_request(:get, "http://where.yahooapis.com/v1/concordance/iso/GB?format=json&appid=#{API_KEYS[:yahoo]}").
      to_return(:body => File.new(asset_path('country_concordance.json')))

    stub_request(:get, "http://where.yahooapis.com/v1/place/23424975?format=json&appid=#{API_KEYS[:yahoo]}").
      to_return(:body => File.new(asset_path('country_woeid.json')))

    APIImporter.new.import_country_metadata
    country.reload
    assert_equal "-13.41393,49.16209,1.76896,60.854691", country.bounding_box
  end

end
