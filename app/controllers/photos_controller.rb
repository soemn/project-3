require 'google/cloud/vision'

class PhotosController < ApplicationController
  before_action :authenticate_user!, only: %i[new index]

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
    image_short_name = image_link[25..60]

    image_long_name = 'http://res.cloudinary.com/dnqgbyfhs/image/upload/v1510589603/' + image_short_name

    vision = Google::Cloud::Vision.new(
      project: ENV['project_name'],
      keyfile: ENV['credentials']
    )

    image = vision.image image_long_name

    result = {}

    image.logos.each do |logo|
      result = logo.description
    end

    brand = Brand.find_by logo: result
    brand_id = brand.id

    current_user.photos.create(
      title: params[:photo][:title],
      description: params[:photo][:description],
      brand_id: brand_id,
      photo_link: image_short_name
    )

    # current_user.interactions.create(
    #   content: params[:interaction][:content],
    #   message_type: params[:interaction][:message_type]
    # )
    # render json: params
  end

  def new
    @new_photo = Photo.new

    @new_interaction = Interaction.new
  end

  def show_profile
    @photos = Photo.where(user_id: params[:id])
    # render json: @photo
  end
end
