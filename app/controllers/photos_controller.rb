class PhotosController < ApplicationController
  def index
    @photos = Photo.all

    render json: @photos
  end

  def show
    @photo = Photo.find(params[:id])

    render json: @photo
  end

  def create
    # find current_user first
    # create new project based on that user
    current_user.photos.create(params.require(:photo).permit(:title))

    redirect_to root_path
  end

  def new
    @new_photo = Photo.new
  end
end
