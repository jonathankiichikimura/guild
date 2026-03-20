class ApplicationController < ActionController::Base
  before_action :authenticate_any!

  def after_sign_in_path_for(resource)
    if resource.is_a?(Giver)
      # Have to change when we have a path for givers.
      quests_path
    else
      quests_path
    end
  end

  private

  def authenticate_any!
    return if devise_controller?

    return if giver_signed_in? || accepter_signed_in?

    redirect_to root_path, alert: "Please sign in to continue."
  end
end
