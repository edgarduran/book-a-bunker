class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :all_locations,
                :current_user,
                :current_admin?,
                :unauthenticated_user_error
  before_action :set_cart,
                :authorize!

  def all_locations
    Location.all
  end

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user ||= User.create
    end
  end

  def current_permission
    @current_permission ||= PermissionService.new(current_user)
  end

  def authorize!
    unless current_permission.allow?(params[:controller], params[:action])
      flash[:notice] = "Page does not exist."
      redirect_to root_path
    end
  end

  def current_admin?
    (current_user && current_user.platform_admin?) || (current_user && current_user.store_admin?)
  end
  #
  # def unauthenticated_user_error
  #   render(file: "/public/404") unless current_user
  # end
  #
  def redirect_path(referrer, normal_redirect)
    referrer || normal_redirect
  end
end
