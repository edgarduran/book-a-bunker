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
        StripeService.new
        mail_service.send_email(current_user.email)
        session[:cart] = nil
        flash[:notice] = "Order successfully placed! Your bunker is secured."
        redirect_to dashboard_path
        new_order.bunkers.each do |bunker|
          bunker.store.orders << new_order unless bunker.store.orders.find_by(id: new_order.id)
        end
      end
    else
      session[:referrer] = URI(request.referrer).path
      redirect_to login_path
    end
    stripe_rescue
  end

  def update
    binding.pry
    @order = Order.find(params[:id])
    @order.update(status: params[:status])
    flash[:success] = "Order Updated."
    redirect_to store_dashboard_path(@order.store)
  end

  private

  def order_params
    params.require(:order).permit(:status, :id)
  end

  def stripe_rescue
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to cart_path
  end

  def mail_service
    MailService.new
  end

end
