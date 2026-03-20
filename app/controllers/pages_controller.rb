class PagesController < ApplicationController
  skip_before_action :authenticate_any!, only: %i[home choice]

  def home
  end

  def choice
  end
end
