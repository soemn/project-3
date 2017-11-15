# require 'google/cloud/vision'

class PhotosController < ApplicationController
  before_action :authenticate_user!, only: %i[new index]

  def index
    @photos = current_user.photos
    # @photos = Photo.all
    # render json: @photos
  end

  def show
    @photo = Photo.find(params[:id])
    @interactions = Interaction.where(photo_id: params[:id])
    # render json: @photo
  end

  def create
    image_link = params[:image]
    image_short_name = image_link[25..60]

    image_long_name = 'http://res.cloudinary.com/dnqgbyfhs/image/upload/v1510589603/' + image_short_name

    response = JSON.parse(get_brand(image_long_name).body)['responses'][0]['logoAnnotations'][0]['description']

    brand = Brand.find_by logo: response
    brand_id = brand.id

    @new_photo = current_user.photos.create(
      title: params[:photo][:title],
      description: params[:photo][:description],
      brand_id: brand_id,
      photo_link: image_short_name
    )
    if @new_photo.save
      redirect_to photos_path
    else
      redirect_to new_photo_path
    end

    # current_user.interactions.create(
    #   content: params[:interaction][:content],
    #   message_type: params[:interaction][:message_type]
    # )
    # render json: params
  end

  def new
    @new_photo = Photo.new

    # @new_interaction = Interaction.new
  end

  def new_interaction
    @new_interaction = Interaction.new
  end

  def show_profile
    @photos = Photo.where(user_id: params[:id])
    @photo_owner = User.find(params[:id])
    # render json: @photo
  end

  protected

  def get_brand(brand_link)
    params = {
      "requests":[
        {
          "image":{
            "source":{
              "imageUri":
                brand_link
            }
          },
          "features":[
            {
              "type":"LOGO_DETECTION",
              "maxResults":1
            }
          ]
        }
      ]
    }.to_json

    address = URI('https://vision.googleapis.com/v1/images:annotate?key=' + ENV['api_key'])

    http = Net::HTTP.new(address.host, address.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new address.request_uri
    request.add_field("Content-Type", "application/json")

    request.body = params

    response = http.request(request)
  end

end
