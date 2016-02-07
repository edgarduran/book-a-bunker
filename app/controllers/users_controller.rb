class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Logged in as #{@user.first_name}"
      path = redirect_path(session[:referrer], dashboard_path)
      session[:referrer] = nil
      redirect_to path
    else
      flash.now[:error] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  def show
    @user = current_user
    if @user.platform_admin? || @user.store_admin?
      redirect_to admin_dashboard_path
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)
    flash[:notice] = "Profile updated!"
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :address,
      :city,
      :state,
      :zipcode,
      :safe_house,
      :password,
      :password_confirmation)
  end
end
