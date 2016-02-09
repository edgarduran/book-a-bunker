class CartBunkersController < ApplicationController
  def create
    days = calculate_days(params[:startDate], params[:endDate])
    bunker = Bunker.find(params[:bunker_id])
    if days <= 0
      flash[:error] = "Must book for at least 1 Night"
      redirect_to URI(request.referer).path
    else
      @cart.add_bunker(bunker.id, days)
      session[:cart] = @cart.contents
      flash[:notice] = "#{bunker.title} has been added to cart for booking"
      redirect_to URI(request.referer).path
    end
  end

  def index
    @bunkers = @cart.cart_bunkers
  end

  def update
    function = params[:function]
    @cart.update_quantity(params[:function], params[:id])
    session[:cart] = @cart.contents
    redirect_to "/cart"
  end

  private
  def calculate_days(start_date, end_date)
    (Date.parse(end_date) - Date.parse(start_date)).to_i
  end

end
