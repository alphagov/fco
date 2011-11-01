class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name, :fco_id, :iso_3166_2, :slug
      t.text :raw_travel_advice, :limit => 4294967295
    end

    add_index :countries, :slug, :unique => true
  end
end
