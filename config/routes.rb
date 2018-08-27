Rails.application.routes.draw do
  root "static_pages#home"
  get "/home", to: "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/index", to: "admin#index"
  get "/info", to: "details#info"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, except: :destroy
  namespace :admin do
    resources :authors
    resources :admin, only: :index
    resources :categories
    resources :users, only: %i(index destroy)
    resources :books
    resources :feedbacks, :reviews, only: %i(index destroy show)
  end
  resources :account_activations, only: :edit
  resources :books do
    resources :reviews
  end
end
