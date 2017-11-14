class BrandsController < ApplicationController
<<<<<<< HEAD
  before_action :authenticate_user!
=======
  before_action :is_admin?, only: [:index]
>>>>>>> adminForm

  def index
    @photos = Photo.all
    # render json: @photos
  end
<<<<<<< HEAD
=======

  def is_admin?
    redirect_to root_path if current_user.admin != true
end
>>>>>>> adminForm
end
