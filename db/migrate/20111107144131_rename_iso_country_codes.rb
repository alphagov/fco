class RenameIsoCountryCodes < ActiveRecord::Migration
  def change
    rename_column(:countries, :iso_3166_2, :iso_3166_1)
  end
end
