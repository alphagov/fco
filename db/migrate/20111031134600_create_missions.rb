class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.string :fco_id, :email, :url, :designation
      t.text :address
      t.decimal :latitude, :precision => 15, :scale => 10
      t.decimal :longitude, :precision => 15, :scale => 10
    end
  end
end
