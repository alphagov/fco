class HomeController < ApplicationController

  def show
    @countries = Country.order('name ASC').all
  end

end