class BunkersController < ApplicationController
  def index
    @bunkers = Bunker.paginate(page: params[:page], :per_page => 10)
  end

  def show
    @bunker = Bunker.find(params[:id])
    if @bunker.active?
      @partial = "partials/add_to_cart"
    end
  end
end
