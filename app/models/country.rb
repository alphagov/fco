class Country < ActiveRecord::Base

  has_many :missions

  validates :name, :presence => true
  validates :iso_3166_2, :presence => true

end
