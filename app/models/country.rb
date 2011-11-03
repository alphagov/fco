class Country < ActiveRecord::Base

  extend SymbolizeAttribute

  TRAVEL_RESTRICTION_STATUSES = [:none, :all, :parts]

  has_many :missions, :foreign_key => "fco_id", :primary_key => "fco_id"

  validates :name, :presence => true
  validates :fco_id, :presence => true
  validates :slug, :presence => true
  validates :iso_3166_2, :presence => true
  validates :no_travel_restriction, :inclusion => { :in => TRAVEL_RESTRICTION_STATUSES, :allow_nil => true }
  validates :essential_travel_restriction, :inclusion => { :in => TRAVEL_RESTRICTION_STATUSES, :allow_nil => true }

  symbolize_attribute :no_travel_restriction
  symbolize_attribute :essential_travel_restriction

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
