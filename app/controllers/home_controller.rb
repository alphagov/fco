class HomeController < ApplicationController

  def show
    expires_in 10.minute, :public => true unless Rails.env.development?
    @countries = Country.order('name ASC').all
    @avoid_travel_countries = Country.avoid_travel.descending_restriction_priority(:avoid_travel_restriction).all
    @essential_travel_countries = Country.essential_travel.descending_restriction_priority(:essential_travel_restriction).all
    @travel_news = TravelNews.order('published_at DESC').all
  end

end
