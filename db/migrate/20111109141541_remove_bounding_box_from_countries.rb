class RemoveBoundingBoxFromCountries < ActiveRecord::Migration
  def change
    remove_column(:countries, :bounding_box)
  end
end
