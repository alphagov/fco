class AddBoundingBoxToCountries < ActiveRecord::Migration
  def change
    add_column(:countries, :bounding_box, :string)
  end
end
