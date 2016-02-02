class BunkersController < ApplicationController
  def index
    @bunkers = Bunker.all
  end

  def show
    @bunker = Bunker.find(params[:id])
    if @bunker.active?
      @partial = "partials/add_to_duffel"
    else
      @partial = "partials/sold_out"
    end
  end
end
