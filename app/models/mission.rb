class Mission < ActiveRecord::Base

  belongs_to :country, :foreign_key => "country_fco_id", :primary_key => "fco_id"

  validates :country_fco_id, :presence => true
  validates :fco_id, :presence => true
  validates :slug, :presence => true, :uniqueness => { :scope => :country_fco_id }
  validates :location_name, :presence => true
  validates :designation, :presence => true

  before_validation :generate_slug

  def generate_slug
    if self.slug.blank?
      candiate_slug = [location_name, designation].select(&:present?).join(" ").to_url
      base_slug = candiate_slug.dup

      i = 2
      until Mission.where('country_fco_id = ? AND slug = ?', country_fco_id, candiate_slug).count == 0 do
        candiate_slug = "#{base_slug}-#{i}"
        i =+ 1
      end

      self.slug = candiate_slug
    end
  end

end
