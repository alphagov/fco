require 'pp'

class APIImporter

  def initialize
    country_csv_path = File.join(Rails.root, 'data', 'country_codes.csv')
    csv = CSV.read(country_csv_path, :headers => true, :encoding => 'U')
    @countries = []
    csv.each do |row|
      @countries << row.to_hash
    end
  end

  def run
    Country.transaction do
      import_countries
      import_missions
      import_travel_advice
    end
  end

  def import_countries
    Country.transaction do
      Country.destroy_all
      fetch_countries.each do |country_json|
        name = normalize_country_name(country_json['country']['name'])
        country = Country.find_or_initialize_by_name(name)
        country.fco_id = country_json['country']['slug']
        country.iso_3166_2 = country_code_for_name(country.name)
        country.save!
      end
    end
  end

  def import_missions
    Mission.transaction do
      Mission.destroy_all
      fetch_missions.each do |embassy_json|
        mission = Mission.new
        mission.fco_id = embassy_json['embassy']['fco_id']
        mission.designation = embassy_json['embassy']['designation']
        mission.latitude = embassy_json['embassy']['lat']
        mission.longitude = embassy_json['embassy']['long']
        mission.save!
      end
    end
  end

  def import_travel_advice
    Country.transaction do
      Country.find_each do |country|
        country.raw_travel_advice = fetch_travel_advice(country)['travel_advice_article']
        country.save!
      end
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
    url = "http://fco.innovate.direct.gov.uk/travel-advice/full_results.json?c%5B%5D=#{country.fco_id}"
    response = RestClient.get(url)
    JSON.parse(response.body).first
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

  def country_code_for_name(name)
    row = @countries.find do |c|
      c['fco_name'] == name
    end
    row.try(:[], 'iso3611_2')
  end

end
