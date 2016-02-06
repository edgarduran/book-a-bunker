class StoreAdmin::DashboardController < ApplicationController

  def index

    @stores = current_user.stores
  end

  def show

  end


end
