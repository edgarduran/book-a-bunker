class Admin::UsersController < Admin::BaseController
  def index
    if params[:filter]
      @orders = Order.filter_orders(params[:filter])
    else
      @orders = Order.all
    end
    @store_admins = Role.find_by(name: "store_admin").users
  end
end
