class BrandsController < ApplicationController
  before_action :is_admin?, only: [:index]

  def index
    @brands = Photo.where(brand_id: params[:id])
  end

  def is_admin?
    redirect_to root_path if current_user.admin != true
  end

  def create
    current_user.brands.create(
      name: params[:brand][:name],
      logo: params[:brand][:logo],
      link: params[:brand][:link]
    )
  end

  def show
    @brand = Photo.where(brand_id: params[:id])
  end

  def new
    @new_brand = Brand.new
  end
end
