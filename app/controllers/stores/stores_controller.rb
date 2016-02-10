class Stores::StoresController < ApplicationController
  before_action :store_not_found
  helper_method :current_store

  def current_store
    @current_store ||= Store.find_by(slug: params[:store_slug])
  end

  def store_not_found
    redirect_to root_path unless current_store
  end
end
