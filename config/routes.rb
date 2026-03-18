Rails.application.routes.draw do
  devise_for :givers,    controllers: { registrations: "givers/registrations" }
  devise_for :accepters, controllers: { registrations: "accepters/registrations" }


  root to: "pages#home"

  resources :quests, only: [:index, :show, :new, :create, :update, :destroy] do
    resources :reviews, only: [:new, :create]
    resources :quest_applications, only: [:create]
  end

  resources :givers, only: [:show]
  resources :accepters, only: [:show]

  get "up" => "rails/health#show", as: :rails_health_check
end
