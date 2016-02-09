class Stores::DashboardController < ApplicationController

  def show
    @store = Store.find_by(id: current_user.store.id)
    @statuses = Order.pluck(:status).uniq.compact
  end
end
