require 'google/cloud/vision'
require 'dotenv/load'
require 'uri'
require 'net/http'
require "net/https"


class BrandsController < ApplicationController
  before_action :authenticate_user!, only: %i(new index)
  before_action :is_admin?, only: [:index]

  def index
    @brands = Brand.all
  end

  def is_admin?
    redirect_to root_path if current_user.admin != true
  end

  def search
    @params = params[:term]

    if @params.length > 0
      @brand = Brand.where(logo: @params)
    end

    @photos = Photo.where(brand_id: @brand)
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

  # def show
  #   @brand = Photo.where(brand_id: params[:id])
  # end

  def new
    @new_brand = Brand.new
  end

  def test
    image = "https://i.pinimg.com/736x/e8/30/04/e830045c365df7abb42bb790f36c464d--captain-america-shoes-marvel-captain-america.jpg"
    response = JSON.parse(get_brand(image).body)
    # check_result = JSON.parse(get_brand(image).body)['responses'][0].present?
    render json: response
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
