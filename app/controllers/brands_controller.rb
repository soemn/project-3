class BrandsController < ApplicationController
  before_action :is_admin?, only: [:index]

  def index
    @brands = Photo.all
    # render json: @photos
  end

  def is_admin?
    redirect_to root_path if current_user.admin != true
end

  def create
    current_user.interactions.create(
      name: params[:brand][:name],
      logo: params[:brand][:logo],
      link: params[:brand][:link]
    )
  end
end
