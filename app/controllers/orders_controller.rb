class OrdersController < ApplicationController
  def index
    if current_user
      @orders = current_user.orders
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

        charge = Stripe::Charge.create(
          :customer => customer.id,
          :amount => @amount,
          :description => 'Rails Stripe customer',
          :currency => 'usd'
        )

        session[:cart] = nil
        flash[:notice] = "Order successfully placed!"
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

# PUBLISHABLE_KEY=pk_test_P2j0SiGEfsE9FVyFKLYvpBkd SECRET_KEY=sk_test_4Po7CVh1tVFZb9ftNQbNy7qM rails s
