class BrandsController < ApplicationController
  before_action :authenticate_user!

  def index
    @photos = Photo.all
    # render json: @photos
  end
end
