Rails.application.routes.draw do
  namespace :stores do
  get 'bunkers/index'
  end

  namespace :stores do
  get 'bunkers/show'
  end

  root "home#welcome"
  get "/dashboard", to: "users#show"
  get "/cart", to: "cart_bunkers#index"
  get "/rules", to: "resources#rules"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/map", to: "maps#show"

  get "/report", to: "outbreaks#new"
  post "/report", to: "outbreaks#create"

  get "/game", to: "games#show"

  resources :users, only: [:new, :create, :edit, :update]
  resources :orders, only: [:index, :create, :show]

  resources :bunkers, only: [:index, :show]
  resources :locations, only: [:show, :index]
  resources :cart_bunkers, only: [:create, :update]
  resources :stores, only: [:index]

  resources :charges

  namespace :admin do
    get "/dashboard", to: "users#index"
    resources :items, only: [:new, :create, :edit, :update, :destroy]
  end

  namespace :stores, path: ":store", as: :store do
    resources :bunkers, only: [:index, :show], param: :slug
  end
end
