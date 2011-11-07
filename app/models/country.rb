class Country < ActiveRecord::Base

  extend SymbolizeAttribute

  TRAVEL_RESTRICTION_STATUSES = [:none, :all, :parts]

  has_many :missions, :foreign_key => "country_fco_id", :primary_key => "fco_id", :dependent => :destroy

  validates :name, :presence => true
  validates :fco_id, :presence => true
  validates :slug, :presence => true
  validates :iso_3166_1, :presence => true
  validates :avoid_travel_restriction, :inclusion => { :in => TRAVEL_RESTRICTION_STATUSES, :allow_nil => true }
  validates :essential_travel_restriction, :inclusion => { :in => TRAVEL_RESTRICTION_STATUSES, :allow_nil => true }

  symbolize_attribute :avoid_travel_restriction
  symbolize_attribute :essential_travel_restriction

  scope :avoid_travel, where(:avoid_travel_restriction => [:all, :parts])
  scope :essential_travel, where(:essential_travel_restriction => [:all, :parts])
  scope :descending_restriction_priority, lambda { |restriction| order("#{restriction.to_s}=\"all\" DESC, #{restriction.to_s}=\"parts\" DESC") }

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
