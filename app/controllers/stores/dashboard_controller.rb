class Stores::DashboardController < ApplicationController

  def show
    @store = Store.find_by(id: current_user.store.id)
  end
end
