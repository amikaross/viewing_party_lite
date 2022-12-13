# frozen_string_literal: true

Rails.application.routes.draw do

  resources :users, only: [:create]

  resources :movies, only: [:show] do 
    resources :viewing_parties, only: [:new, :create]
  end

  get "/register", to: "users#new"
  get "/dashboard", to: "users#show"

  get "/discover", to: "movies#discover"
  get "/movies", to: "movies#index"

  get "/login", to: "users#login_form"
  post "/login", to: "users#login_user"
  get "/logout", to: "users#logout_user"
  
  get '/', to: 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
