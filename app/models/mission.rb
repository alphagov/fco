class Mission < ActiveRecord::Base

  belongs_to :country, :foreign_key => "fco_id", :primary_key => "fco_id"

  # validates :designation, :presence => true
  validates :fco_id, :presence => true
  validates :latitude, :presence => true
  validates :longitude, :presence => true

end
