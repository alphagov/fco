module AssetHelpers

  def asset_path(filename)
    File.join(Rails.root, 'test', 'assets', filename)
  end

end
