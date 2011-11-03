class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.string :country_fco_id, :fco_id, :email, :url, :designation, :location_name, :phone
      t.text :address, :office_hours
      t.decimal :latitude, :precision => 15, :scale => 10
      t.decimal :longitude, :precision => 15, :scale => 10
    end

    add_index :missions, :fco_id
  end
end
