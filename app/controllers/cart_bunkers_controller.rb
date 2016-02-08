class CartBunkersController < ApplicationController
  def create
    days = calculate_days(params[:startDate], params[:endDate])
    bunker = Bunker.find(params[:bunker_id])
    @cart.add_bunker(bunker.id, days)
    session[:cart] = @cart.contents
    flash[:notice] = "#{bunker.title} has been added to cart for booking"
    redirect_to URI(request.referer).path
  end

  def index
    @bunkers = @cart.cart_bunkers
  end

  def update

  end

  private
  def calculate_days(start_date, end_date)
    (Date.parse(end_date) - Date.parse(start_date)).to_i
  end

end
