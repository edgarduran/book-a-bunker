class Stores::BunkersController < ApplicationController
  def index
    @store = Store.find_by(slug: params[:store])
    @bunkers = @store.bunkers
  end

  def show
  end
end
