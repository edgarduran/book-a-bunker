class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      if @user.platform_admin?
        path = redirect_path(session[:referrer], admin_dashboard_path)
        session[:referrer] = nil
        redirect_to path
        flash[:success] = "Logged in as #{@user.first_name} #{@user.last_name}"
      elsif @user.store_admin?
        path = redirect_path(session[:referrer], "/#{@user.store.slug}/dashboard")
        session[:referrer] = nil
        redirect_to path
        flash[:success] = "Logged in as #{@user.first_name} #{@user.last_name}"
      else @user.registered_user?
        path = redirect_path(session[:referrer], dashboard_path)
        session[:referrer] = nil
        redirect_to path
        flash[:success] = "Logged in as #{@user.first_name} #{@user.last_name}"
      end
    else
      flash[:notice] = 'Invalid Login'
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    flash[:notice] = "You have successfully logged out."
    redirect_to login_path
  end

end
