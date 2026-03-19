class QuestsController < ApplicationController
  def index
    @quests = Quest.where(status: "open")
  end

  def show
    @quest = Quest.find(params[:id])
  end

  def new
    @quest = Quest.new
  end

  def create
    @quest = Quest.new(quest_params)
    @quest.giver = current_giver
    if @quest.save
      redirect_to giver_path(current_giver)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private

  def quest_params
    params.require(:quest).permit(:title, :description, :reward_amount, :reward_type, :address_full, :suburb,
                                  :category)
  end
end
