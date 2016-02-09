class Stores::BunkersController < Stores::StoresController

  def index
    @bunkers = current_store.bunkers
  end

  def show
  end

  def new

  end

end
