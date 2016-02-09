class LocationsController < ApplicationController

  def index
    @locations = Location.paginate(page: params[:page], :per_page => 10)
  end

  def show
    @location = Location.find_by(slug: params[:slug])
    @locations = @location.bunkers.paginate(page: params[:page], :per_page => 10)
  end
end
