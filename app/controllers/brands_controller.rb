require 'google/cloud/vision'
require 'dotenv/load'
require 'uri'
require 'net/http'
require "net/https"


class BrandsController < ApplicationController
  before_action :authenticate_user!, only: %i(new index)
  before_action :is_admin?, only: [:index]

  def index
    @brands = Photo.where(brand_id: params[:id])
  end

  def is_admin?
    redirect_to root_path if current_user.admin != true
  end

  def create
    @brand = Brand.create(
      name: params[:brand][:name],
      logo: params[:brand][:logo],
      link: params[:brand][:link]
    )
    if @brand.save
      redirect_to brands_path
    else
      redirect_to new_brand_path
  end
  end

  def show
    @brand = Photo.where(brand_id: params[:id])
  end

  def new
    @new_brand = Brand.new
  end

  def test
  
    params = {
      "requests":[
        {
          "image":{
            "source":{
              "imageUri":
                "http://res.cloudinary.com/dnqgbyfhs/image/upload/v1/user_photos/finwgfz6ripn3ddafdrq.jpg"
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

    render json: response.body
  end
end
