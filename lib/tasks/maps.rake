namespace :maps do
  task :generate_border_files do
    borders_json_file = File.read(File.join(Rails.root, 'data', 'borders.json'))
    borders_json = JSON.parse(borders_json_file)

    borders_json['features'].each do |feature|
      iso_code = feature['properties']['ISO_A2']
      next if iso_code == "-99"
      file_path = File.join(Rails.root, 'public', 'fco-assets', 'borders', "#{iso_code}.json")
      File.open(file_path, 'w') do |f|
        f.write feature.to_json
      end
    end
  end
end