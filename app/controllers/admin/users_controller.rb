class Admin::UsersController < Admin::BaseController
  def index
    if params[:filter]
      @orders = Order.filter_orders(params[:filter])
    else
      @orders = Order.all
    end
    @store_admins = Role.find_by(name: "store_admin").users
    @store_application = Store.find_by(approved: nil)
  end
end
