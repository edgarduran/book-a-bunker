class HomeController < ApplicationController
  def welcome
    @locations = Location.all
  end
end
