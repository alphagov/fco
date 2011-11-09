# encoding: UTF-8

require 'csv'

class APIImporter

  def initialize
    country_csv_path = File.join(Rails.root, 'data', 'country_codes.csv')
    csv = CSV.read(country_csv_path, :headers => true, :encoding => "UTF-8")
    @countries = []
    csv.each do |row|
      @countries << row.to_hash
    end
  end

  def run
    Country.transaction do
      import_countries
      import_travel_advice
      import_travel_news
      import_advice_statuses
    end
  end

  def import_countries
    Country.transaction do
      Country.delete_all
      Mission.delete_all
      fetch_countries.each do |country_json|
        fco_id = normalize_fco_id(country_json['country']['slug'])
        country = Country.find_or_initialize_by_fco_id(fco_id)
        name = normalize_country_name(country_json['country']['name'])
        country.name = name
        country.slug = name.to_url
        country.iso_3166_1 = country_code_for_name(name)
        Rails.logger.debug "Importing #{country.name} (#{country.fco_id}/#{country.slug})"
        country.save!

        country_json['country']['embassies'].each do |embassy_json|
          m = country.missions.new
          m.email = embassy_json['email']

          # if there's no URL, then the API sets a default URL - we don't want this
          if embassy_json['original_url'] !=  'http://www.fco.gov.uk/'
            m.url = embassy_json['original_url']
          end

          m.fco_id = embassy_json['fco_id']
          m.latitude = embassy_json['lat']
          m.longitude = embassy_json['long']
          m.designation = embassy_json['designation'].presence
          m.office_hours = embassy_json['office_hours']['plain']
          m.address = embassy_json['address']['plain']
          m.location_name = embassy_json['location_name'].presence
          m.phone = embassy_json['phone'].presence
          m.save!
        end
      end
    end
  end

  def import_travel_advice
    Country.transaction do
      Country.find_each do |country|
        Rails.logger.debug "Importing travel advice for #{country.name} (#{country.fco_id})"
        country.raw_travel_advice = fetch_travel_advice(country).try(:[], 'travel_advice_article')
        country.save!
      end
    end
  end

  def import_travel_news
    TravelNews.transaction do

      TravelNews.delete_all
      fetch_travel_news.each do |news_json|
        tn = TravelNews.new
        tn.title = news_json['travel_news']['title']
        tn.published_at = Time.iso8601(news_json['travel_news']['published_on'])
        tn.body_plain = news_json['travel_news']['body']['plain']
        tn.body_markup = news_json['travel_news']['body']['markup']
        tn.description = news_json['travel_news']['description']
        tn.url = news_json['travel_news']['original_url']
        tn.save!
      end
    end
  end

  def import_advice_statuses
    Country.transaction do
      advice = fetch_country_advice

      # We want countries that are referenced in the HTML but we don't have in the app to raise
      missing_country_names = advice.values.flatten

      Country.find_each do |country|
        name = normalize_name_for_travel_advice_status(country.name)
        missing_country_names.delete(name)

        if advice['noTravelAll'].include?(name)
          country.avoid_travel_restriction = :all
        elsif advice['noTravelParts'].include?(name)
          country.avoid_travel_restriction = :parts
        else
          country.avoid_travel_restriction = :none
        end

        if advice['essentialTravelAll'].include?(name)
          country.essential_travel_restriction = :all
        elsif advice['essentialTravelParts'].include?(name)
          country.essential_travel_restriction = :parts
        else
          country.essential_travel_restriction = :none
        end

        country.save!
      end

      raise "Unmatched countries: #{missing_country_names.join(', ')}" if missing_country_names.length > 0
    end
  end

  private

  def fetch_countries
    response = RestClient.get("http://fco.innovate.direct.gov.uk/countries.json")
    JSON.parse(response.body)
  end

  def fetch_missions
    response = RestClient.get("http://fco.innovate.direct.gov.uk/embassies.json")
    JSON.parse(response.body)
  end

  def fetch_travel_advice(country)
    fco_id = normalize_fco_id(country.fco_id)
    begin
      url = "http://fco.innovate.direct.gov.uk/travel-advice/full_results.json?c%5B%5D=#{fco_id}"
      response = RestClient.get(url)
      JSON.parse(response.body).first
    rescue RestClient::ResourceNotFound
      nil
    end
  end

  def fetch_travel_news
    response = RestClient.get("http://fco.innovate.direct.gov.uk/travel-news.json")
    JSON.parse(response.body)
  end

  def fetch_country_advice
    response = RestClient.get("http://www.fco.gov.uk/en/travel-and-living-abroad/travel-advice-by-country?action=noTravelAll")
    html = Nokogiri::HTML.parse(response.body)

    # Outputs a hash of each of the Heading IDs, with an array of the countries they refer to.
    Hash.new.tap do |output|
      html.css('#Main h2')[2..-1].each do |h2|
        name = h2.css('a').first['name']
        output[name] = []
        ul = h2.next_element
        ul.css('li').each do |li|
          output[name] << li.css('a')[0].inner_text.strip
        end
      end
    end
  end

  def normalize_country_name(name)
    case name
    when "East Timor (Timor-Leste)"
      "Timor-Leste"
    when "Gambia, The"
      "Gambia"
    when "Korea"
      "South Korea"
    when "Kyrgystan"
      "Kyrgyzstan"
    else
      name.strip
    end
  end

  def normalize_fco_id(fco_id)
    case fco_id
    when 'timor-leste'
      'east-timor-(timor-leste)'
    when 'south-korea'
      'korea'
    when 'gambia'
      'gambia,-the'
    when 'kyrgystan'
      'kyrgyzstan'
    when 'south-georgia-and-south-sandwich-islands'
      'south-georgia-south-sandwich'
    else
      fco_id
    end
  end

  def normalize_name_for_travel_advice_status(name)
    case name
    when "Israel"
      "Israel and the Occupied Palestinian Territories"
    when /Ivory Coast/
      "Côte d'Ivoire (Ivory Coast)"
    else
      name
    end
  end

  def country_code_for_name(name)
    row = @countries.find do |c|
      c['fco_name'] == name
    end
    row['iso3166_1']
  end

end
