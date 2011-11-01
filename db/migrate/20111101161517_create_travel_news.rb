class CreateTravelNews < ActiveRecord::Migration
  def change
    create_table :travel_news do |t|
      t.text :body_plain, :body_markup, :description
      t.string :title, :url
      t.datetime :published_at
    end
  end
end
