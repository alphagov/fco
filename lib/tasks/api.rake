namespace :api do

  task :import => :environment do
    APIImporter.new.run
  end

end