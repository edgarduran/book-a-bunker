class StoresController < ApplicationController
  def index
    @stores = Store.where(approved: true)
  end

  def show
    @store = Store.find_by(slug: params[:slug])
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      flash[:success] = "Store application submitted."
      @store.users << current_user
      redirect_to dashboard_path
    else
      flash[:success] = "Store application not submitted."
      redirect_to dashboard_path
    end
  end

  def update
    store = Store.find(params[:id])
    role = Role.find_by(name: "store_admin")
    removed_role = Role.find_by(name: "registered_user")
    case params[:approved]
    when "deactivate"
      store.update(approved: false)
      flash[:notice] = "Store deactivated."
    when "true"
      store.users.first.roles << role
      store.update(approved: true)
      flash[:success] = "Store approved."
    when "false"
      store.update(approved: false)
      flash[:notice] = "Store denied."
    end
    redirect_to admin_dashboard_path
  end

  def edit
    @store = Store.find(params[:id])
  end

  def changes
    store = Store.find(params[:id])
    if store.update(store_params)
      flash[:success] = "#{store.name} has been updated"
      redirect_to store_dashboard_path(store_slug: store.slug)
    else
      flash[:error] = "Please fill out with valid information"
      render :edit
    end
  end

  private

  def store_params
    params.require(:store).permit(:name, :description, :approved)
  end
end
