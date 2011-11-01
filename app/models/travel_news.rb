class TravelNews < ActiveRecord::Base

  validates :title, :presence => true
  validates :published_at, :presence => true
  validates :body_plain, :presence => true
  validates :body_markup, :presence => true
  validates :description, :presence => true
  validates :url, :presence => true

end
