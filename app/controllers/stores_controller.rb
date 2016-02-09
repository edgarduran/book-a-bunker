class StoresController < ApplicationController
  def index
    @stores = Store.all
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
      redirect_to dashboard_path
    else
      flash[:success] = "Store application not submitted."
      redirect_to dashboard_path
    end
  end

  private

  def store_params
    params.require(:store).permit(:name, :description)
  end


end
