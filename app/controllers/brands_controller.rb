class BrandsController < ApplicationController
  before_action :is_admin?, only: [:index]

  def index
    @photos = Photo.all
    # render json: @photos
  end

  def is_admin?
    redirect_to root_path if current_user.admin != true
end
end
