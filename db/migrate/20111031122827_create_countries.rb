class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name, :fco_id, :iso_3166_2
      t.text :raw_travel_advice
    end
  end
end
