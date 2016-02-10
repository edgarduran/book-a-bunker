class Stores::DashboardController < ApplicationController
  before_action :find_statuses

  def show
    @store = Store.find_by(id: current_user.store.id)
  end

  def index
    @store = current_user.store
  end

  private

  def find_statuses
    @statuses = Order.pluck(:status).uniq.compact
  end
end
