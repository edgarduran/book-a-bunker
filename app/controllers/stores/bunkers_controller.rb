class Stores::BunkersController < Stores::StoresController

  def index
    @bunkers = current_store.bunkers
  end

  def show
    @bunker = Bunker.find(params[:slug])
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

  def edit
    @bunker = Bunker.find(params[:slug])
    @store = current_store
  end

  def update
    @bunker = Bunker.find(params[:slug])
    @bunker.update_attributes(bunker_params)
    flash[:notice] = "Bunker Updated!"
    redirect_to store_bunker_path(current_store.slug, @bunker)
  end

  def destroy
    Bunker.find_by(params[:id]).destroy
    flash[:notice] = "Bunker has been Deleted!"
    redirect_to store_bunkers_path(current_store.slug)
  end

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
