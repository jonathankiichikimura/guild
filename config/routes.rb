Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"

  resources :quests, only: [:index, :show, :new, :create, :update, :destroy] do
    resources :reviews, only: [:new, :create]
  end

  resources :users, only: [:show]

  get "up" => "rails/health#show", as: :rails_health_check
end
