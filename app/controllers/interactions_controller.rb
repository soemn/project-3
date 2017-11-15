class InteractionsController < ApplicationController
  before_action :authenticate_user!, only: %i[new index]

  def index
    @interactions = current_user.interactions
    render json: @interactions
  end

  def show
    @interactions = Interaction.where(user_id: params[:id])
  end

  def create
    photo_id = params[:interaction][:photo_id]
    current_user.interactions.create(
      content: params[:interaction][:content],
      message_type: params[:interaction][:message_type],
      photo_id: photo_id
    )

    redirect_to photo_path(id: photo_id)
  end

  def new
    @new_interaction = Interaction.new
  end
end
