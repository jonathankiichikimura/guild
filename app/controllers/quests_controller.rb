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
    @quest.quest_giver = current_user
    if @quest.save!
      redirect_to user_path(current_user)
    else
      render :new, status: :unprocessed_entity
    end
  end

  def update
  end

  def destroy
  end

  private

  def quest_params
    params.require(:quest).permit(:title, :description, :reward, :category, :location, :experience, :status)
  end
end
