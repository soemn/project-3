class PhotosController < ApplicationController
  before_action :authenticate_user!, only: :index

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
    # current_user.photos.create(params.require(:photo).permit(:title, :description, :photo_link))

    # uploaded_file = params[:image]
    # params[:person][:picture].path
    # render json: uploaded_file
    # cloudnary_file = Cloudinary::Uploader.upload(uploaded_file)
    # render params[:image]
    #
    render json: params
    # redirect_to root_path
  end

  def new
    @new_photo = Photo.new
  end
end
