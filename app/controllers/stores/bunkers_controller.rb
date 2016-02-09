class Stores::BunkersController < Stores::StoresController

  def index
    @bunkers = current_store.bunkers
  end

  def show
  end

  def new
    @bunker = Bunker.new
    @store = current_store
  end

  def create
    @bunker = Bunker.new(bunker_params)
    if @bunker.save
      current_store.bunkers << @bunker
      flash[:notice] = "New Bunker Created!"
      redirect_to store_bunkers_path(current_store.slug)
    else
      flash.now[:error] = @bunker.errors.full_messages.join(", ")
      render :new
    end
  end

  # def destroy
  #   @bunker = Bunker.find_by(params:)
  # end

  private

  def bunker_params
    params.require(:bunker).permit(
      :title,
      :description,
      :price,
      :image,
      :bedrooms,
      :bathrooms,
      )
  end

end
