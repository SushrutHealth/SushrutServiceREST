Prngs::Application.routes.draw do

  root :to => "home#index"
  
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  match "/login", to: "sessions#new", :as => "login"
  match "/logout", to: "sessions#destroy", :as => "logout"

  match "/auth/:provider/callback", to: "sessions#create"
  match "/auth/failure", to: "sessions#failure"

  post "/deauth/:provider", to: "users#deauth", :as => "deauth"

  resources :users

  resources :sources

  resources :mentions

  resources :artists

  resources :videos do
    get :autocomplete_video_and_sources_and_artists_search, :on => :collection
  end

  post "/search", to: "searches#search", :as => "search"
end
