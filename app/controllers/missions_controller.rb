class MissionsController < ApplicationController

  before_filter :scope_country

  def show
    expires_in 10.minute, :public => true unless Rails.env.development?
    @mission = @country.missions.find_by_slug!(params[:id])
  end

  private

  def scope_country
    @country = Country.find_by_slug!(params[:country_id])
  end

end
