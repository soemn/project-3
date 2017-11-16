class RewardsController < ApplicationController
  before_action :authenticate_user!, only: %i[new redeem show create]

  def index
    @rewards = Reward.all
    @new_redemption = Redemption.new

    @total_points = check_points if current_user
  end

  def create
    @reward = Reward.create(
      name: params[:reward][:name],
      required_points: params[:reward][:required_points],
      photo_link: params[:reward][:photo_link]
    )
    if @reward.save
      redirect_to rewards_path
    else
      redirect_to new_reward_path
    end
  end

  def redeem
    @reward_id = params[:redemption][:reward_id]

    points_required = Reward.find(@reward_id).required_points

    if check_points > points_required
      @new_redemption = current_user.redemptions.create(
        reward_id: @reward_id
      )
      redirect_to rewards_show_path
    else
      flash[:notice] = 'Insuccifient Points'
      redirect_to rewards_path
    end
  end

  def show
    @all_rewards = Redemption.where(user_id: current_user.id)
  end

  def new
    @new_reward = Reward.new
  end

  protected

  def check_points
    total_points = 0

    user_photos = Photo.where(user_id: current_user.id)

    if user_photos
      user_photos.each do |photo|
        photo_points = Interaction.where(['photo_id = ? and message_type = ?', photo.id, 1]).length
        total_points += photo_points
      end
    end

    user_redemptions = Redemption.where(user_id: current_user.id)

    if user_redemptions
      user_redemptions.each do |redemption|
        redeemed_points = redemption.reward.required_points
        total_points -= redeemed_points
      end
    end

    @total_points = total_points
  end
end
