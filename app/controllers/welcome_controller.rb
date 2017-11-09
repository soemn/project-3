class WelcomeController < ApplicationController
  def index
    @photos = Photo.all
    # render json: @photos
  end

  def show_brand
    # create new interaction based on params[:brand_id]

    # redirect_to
  end
end
