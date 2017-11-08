class PhotosController < ApplicationController
  def new
    @new_photo = Photo.new
  end
end
