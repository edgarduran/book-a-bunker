class CartBunkersController < ApplicationController
  def create
    bunker = Bunker.find(params[:bunker_id])
    @cart.add_bunker(bunker.id)
    session[:cart] = @cart.contents
    flash[:notice] = "#{bunker.title} has been added to cart for booking"
    redirect_to URI(request.referer).path
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
end
