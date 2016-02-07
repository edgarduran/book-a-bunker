class Admin::UsersController < Admin::BaseController
  def index
    if params[:filter]
      @orders = Order.filter_orders(params[:filter])
    else
      @orders = Order.all
    end
    role = Role.find_by(name: "store_admin")
    @store_admins = role.users
  end
end
