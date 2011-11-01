class Country < ActiveRecord::Base

  has_many :missions, :foreign_key => "fco_id", :primary_key => "fco_id"

  validates :name, :presence => true
  validates :fco_id, :presence => true
  validates :slug, :presence => true
  validates :iso_3166_2, :presence => true

  def to_param
    slug
  end

  def raw_travel_advice=(object)
    write_attribute(:raw_travel_advice, object.try(:to_json))
  end

  def raw_travel_advice
    json = read_attribute(:raw_travel_advice)
    JSON.parse(json) if json
  end

end
