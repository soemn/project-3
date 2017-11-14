class PhotosController < ApplicationController
  before_action :authenticate_user!, only: %i(new index)

  def index
    @photos = current_user.photos
    # @photos = Photo.all
    # render json: @photos
  end

  def show
    @photo = Photo.find(params[:id])
    @interactions = Interaction.where(user_id: params[:id])
    # render json: @photo
  end

  def create
    image_link = params[:image]
    image = image_link[25..60]

    current_user.photos.create(
      title: params[:photo][:title],
      description: params[:photo][:description],
      photo_link: image
    )

    current_user.interactions.create(
      content: params[:interaction][:content],
      message_type: params[:interaction][:message_type]
    )
    # render json: params
  end

  def new
    @new_photo = Photo.new

    @new_interaction = Interaction.new
  end
end
