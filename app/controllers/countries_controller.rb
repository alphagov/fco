class CountriesController < ApplicationController

  def show
    @country = Country.find_by_slug!(params[:id])
    @section_presenters = @country.raw_travel_advice['travel_advice_sections'].map do |s|
      TravelAdviceSectionPresenter.new(s)
    end
    @missions = @country.missions
  end

end
