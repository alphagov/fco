class Mission < ActiveRecord::Base

  belongs_to :country, :foreign_key => "country_fco_id", :primary_key => "fco_id"

  validates :country_fco_id, :presence => true
  validates :fco_id, :presence => true

end
