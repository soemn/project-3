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
    image_path = 'https://yt3.ggpht.com/-160t02WOZiA/AAAAAAAAAAI/AAAAAAAAAAA/RJ1iA6f_20o/s900-c-k-no-mo-rj-c0xffffff/photo.jpg'

    vision = Google::Cloud::Vision.new(
      project: 'distributed-amp-185915',
      keyfile: '83623-fc8c5d0cb28d.json'
    )

    image = vision.image image_path

    result = {}

    image.logos.each do |logo|
      result = logo.description
    end

    render json: result
  end
end
