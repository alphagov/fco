class CountriesController < ApplicationController

  def show
    @country = Country.find_by_fco_id!(params[:id])
  end

end
