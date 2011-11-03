class TravelNews < ActiveRecord::Base

  validates :title, :presence => true
  validates :slug, :presence => true
  validates :published_at, :presence => true
  validates :body_plain, :presence => true
  validates :body_markup, :presence => true
  validates :description, :presence => true
  validates :url, :presence => true

  def title=(new_title)
    write_attribute(:title, new_title)
    write_attribute(:slug, new_title.try(:to_url))
  end

end
