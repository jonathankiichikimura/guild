class GiversController < ApplicationController
  def show
    @giver = Giver.find(params[:id])
  end
end
