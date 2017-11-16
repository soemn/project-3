class InteractionsController < ApplicationController
  before_action :authenticate_user!

  def create
    photo_id = params[:interaction][:photo_id]

    unless params[:interaction][:content].empty?
      current_user.interactions.create(
        content: params[:interaction][:content],
        message_type: params[:interaction][:message_type],
        photo_id: photo_id
      )
    end

    redirect_to photo_path(id: photo_id)
  end

  def like
    photo_id = params[:interaction][:photo_id]

    if Interaction.where(['photo_id = ? and message_type = ? and user_id = ?', photo_id, 1, current_user.id]).empty?
      current_user.interactions.create(
        message_type: params[:interaction][:message_type],
        photo_id: photo_id
      )
    end

    redirect_to photo_path(id: photo_id)
  end
end
