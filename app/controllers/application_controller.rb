class ApplicationController < ActionController::Base
  before_action :authenticate_any!

  private

  def authenticate_any!
    return if devise_controller?
    unless giver_signed_in? || accepter_signed_in?
      redirect_to root_path, alert: "Please sign in to continue."
    end
  end
end
