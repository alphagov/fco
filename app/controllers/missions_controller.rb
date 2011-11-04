class MissionsController < ApplicationController

  before_filter :scope_country

  def show
    @mission = @country.missions.find_by_slug!(params[:id])
  end

  private

  def scope_country
    @country = Country.find_by_slug!(params[:country_id])
  end

end