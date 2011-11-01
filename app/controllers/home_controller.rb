class HomeController < ApplicationController

  def show
    @countries = Country.order('name ASC').all
    @travel_news = TravelNews.order('published_at DESC').all
  end

end