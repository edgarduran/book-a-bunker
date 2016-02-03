Rails.application.routes.draw do
  root "home#welcome"

  namespace :admin do
    get "/dashboard", to: "users#index"
    resources :items, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :users, only: [:new, :create, :edit, :update]
  resources :orders, only: [:index, :create, :show]

  resources :bunkers, only: [:index, :show]
  resources :locations, only: [:show, :index]
  resources :cart_bunkers, only: [:create, :update]

  get "/dashboard", to: "users#show"
  get "/cart", to: "cart_items#index"
  get "/rules", to: "resources#rules"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/map", to: "maps#show"

  get "/report", to: "outbreaks#new"
  post "/report", to: "outbreaks#create"

  get "/game", to: "games#show"
end
