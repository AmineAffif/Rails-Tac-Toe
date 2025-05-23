Rails.application.routes.draw do
  get "sessions/new"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resource :session, only: [:new, :create, :destroy]
  get "/login", to: "sessions#new"
  resources :users, only: [:new, :create]

  # Defines the root path route ("/")
  root "games#new"

  resources :games, only: [:new, :create, :show] do
    member do
      post :move
      post :invite
    end

    collection do
      get :invite 
      post :create_1v1
    end
  end

  get "/my_games", to: "games#my_games"
end
