class Stores::BunkersController < Stores::StoresController
  before_action :find_bunker, only: [:show, :edit, :update]

  def index
    @bunkers = current_store.bunkers.paginate(page: params[:page], :per_page => 10)
  end

  def show
  end

  def new
    @bunker = Bunker.new
    @store = current_store
    @locations = Location.all
  end

  def create
    @location = Location.find(params[:bunker][:location_id])
    @bunker = @location.bunkers.create(bunker_params)
    current_store.bunkers << @bunker
    flash[:notice] = "New Bunker Created!"
    redirect_to store_bunkers_path(current_store.slug)
  end

  def edit
    @store = current_store
  end

  def update
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

  def find_bunker
    @bunker = Bunker.find(params[:slug])
  end

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
