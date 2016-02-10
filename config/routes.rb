Rails.application.routes.draw do
  root "home#welcome"
  get "/dashboard", to: "users#show"
  get "/cart", to: "cart_bunkers#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, only: [:new, :create, :edit, :update]
  resources :orders, only: [:index, :create, :show]

  resources :bunkers, only: [:index, :show]
  resources :locations, only: [:show, :index], param: :slug
  resources :cart_bunkers, only: [:create, :update]
  resources :stores, only: [:index, :new, :create, :update]

  resources :charges, only: [:new]

  namespace :admin do
    get "/dashboard", to: "users#index"
  end

  namespace :stores, path: ":store_slug", as: :store do
    resources :bunkers, param: :slug
    get "/dashboard", to: "dashboard#index"
  end

end
