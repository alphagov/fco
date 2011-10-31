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
      Country.destroy_all

      fetch_countries.each do |country_json|
        name = normalize_country_name(country_json['country']['name'])
        puts "Importing #{name}"
        country = Country.find_or_initialize_by_name(name)
        country.iso_3166_2 = country_code_for_name(country.name)
        country.save!
      end
    end
  end

  private

  def fetch_countries
    response = RestClient.get("http://fco.innovate.direct.gov.uk/countries.json")
    JSON.parse(response.body)
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
