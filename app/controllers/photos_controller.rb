class PhotosController < ApplicationController
  before_action :authenticate_user!, only: %i[new index]

  def index
    @photos = current_user.photos

    @photos.each do |photo|
      photo.points = Interaction.where(["photo_id = ? and message_type = ?", photo.id, 1]).length
    end

  end

  def show
    @photo = Photo.find(params[:id])
    @photo_id = params[:id]
    @photo_points = Interaction.where(["photo_id = ? and message_type = ?", params[:id], 1]).length
    @interactions = Interaction.where(["photo_id = ? and message_type = ?", params[:id], 0])

    @new_interaction = Interaction.new
  end

  def create
    image_link = params[:image]
    image_short_name = image_link[25..60]
    image_long_name = 'http://res.cloudinary.com/dnqgbyfhs/image/upload/v1510589603/' + image_short_name

    check_result = JSON.parse(get_brand(image_long_name).body)['responses'][0]

    brand_id = nil

    if (check_result.present?)
      response = check_result['logoAnnotations'][0]['description']
      brand = Brand.find_by logo: response
      brand_id = brand.id
    end

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
  end

  def new
    @new_photo = Photo.new
  end

  def show_profile
    @photos = Photo.where(user_id: params[:id])
    @photo_owner = User.find(params[:id])
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
