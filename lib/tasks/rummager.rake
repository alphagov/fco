namespace :rummager do
  desc "Reindex search engine"
  task :index => :environment do
    documents = Country.all.map { |country| {
      "title"             => "Travel advice for #{country.name}",
      "description"       => "",
      "format"            => "fco",
      "link"              => "/travel-advice/countries/#{country.slug}",
      "indexable_content" => country.indexable_content
    }}
    Rummageable.index documents
  end
end
