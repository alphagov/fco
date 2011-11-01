class CountriesController < ApplicationController

  def show
    @country = Country.find_by_slug!(params[:id])
  end

end
