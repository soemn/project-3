class RewardsController < ApplicationController
  before_action :authenticate_user!, only: %i(new index)

  def index
    @rewards = Reward.all
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

  def new
    @new_reward = Reward.new
  end
end
