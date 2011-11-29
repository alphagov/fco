class TravelNewsController < ApplicationController

  def show
    expires_in 10.minute, :public => true unless Rails.env.development?
    date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    slug = params[:slug]

    @travel_news = TravelNews.find_by_date_and_slug!(date, slug)
  end

end
