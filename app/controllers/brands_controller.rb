class BrandsController < ApplicationController
<<<<<<< HEAD
  before_action :authenticate_user!
=======
  before_action :is_admin?, only: [:index]
>>>>>>> adminForm

  def index
    @brands = Photo.where(brand_id: params[:id])
  end
<<<<<<< HEAD
=======

  def is_admin?
    redirect_to root_path if current_user.admin != true
<<<<<<< HEAD
end
>>>>>>> adminForm
=======
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
>>>>>>> adminForm
end
