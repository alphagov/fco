namespace :rummager do
  desc "Reindex search engine"
  task :index => :environment do
    documents = []
    Rummageable.index documents
  end
end
