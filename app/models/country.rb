class Country < ActiveRecord::Base

  has_many :missions, :foreign_key => "fco_id", :primary_key => "fco_id"

  serialize :raw_travel_advice, JsonCoder.new

  validates :name, :presence => true
  validates :fco_id, :presence => true
  validates :iso_3166_2, :presence => true

  def to_param
    fco_id
  end

end
