class RewardsController < ApplicationController
  before_action :authenticate_user!, only: %i[new]

  def index
    @rewards = Reward.all
    @new_redemption = Redemption.new
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
    @new_redemption = current_user.redemptions.create(
      reward_id: params[:redemption][:reward_id]
    )

    redirect_to rewards_show_path
  end

  def show
    @all_rewards = Redemption.where(user_id: current_user.id)
  end

  def new
    @new_reward = Reward.new
  end
end
