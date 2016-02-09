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

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, only: [:new, :create, :edit, :update]
  resources :orders, only: [:index, :create, :show]

  resources :bunkers, only: [:index, :show]
  resources :locations, only: [:show, :index], param: :slug
  resources :cart_bunkers, only: [:create, :update]
  resources :stores, only: [:index, :new, :create]

  resources :charges, only: [:new]

  namespace :admin do
    get "/dashboard", to: "users#index"
    resources :items, only: [:new, :create, :edit, :update, :destroy]
  end

  namespace :stores, path: ":store", as: :store do
    resources :bunkers, only: [:index, :show], param: :slug
    resources :dashboard, only: [:show]
  end

end
