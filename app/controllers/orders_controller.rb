class OrdersController < ApplicationController
  def index
    if current_user
      @orders = current_user.orders.reverse
    else
      unauthenticated_user_error
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    if current_user
      new_order = Order.new(user_id: current_user.id) do |order|
        @cart.contents.each do |bunker_id, quantity|
          order.order_bunkers.new(bunker_id: bunker_id, quantity: quantity)
        end
      end
      if new_order.save
        session[:cart] = nil
        flash[:notice] = "Order was successfully placed."
        redirect_to orders_path
      end
    else
      session[:referrer] = URI(request.referrer).path
      redirect_to login_path
    end
  end
end
