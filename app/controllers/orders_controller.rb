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
        @amount = (@cart.bunker_totals.sum) * 100

        customer = Stripe::Customer.create(
          :email => params[:stripeEmail],
          :source => params[:stripeToken]
        )

        Stripe::Charge.create(
          :customer => customer.id,
          :amount => @amount,
          :description => 'Rails Stripe customer',
          :currency => 'usd'
        )

        session[:cart] = nil
        flash[:notice] = "Order successfully placed! Your bunker is secured."
        redirect_to dashboard_path
      end

    else
      session[:referrer] = URI(request.referrer).path
      redirect_to login_path
    end
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to cart_path
  end
end
