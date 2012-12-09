MarketImg::Application.routes.draw do
  resources :banners

  get "photos/new"

  get "photos/index"

  get "photos/show"

  resources :items do
    resources :photos
  end
  
  namespace :user do
    resources :photos
  end
  
  resources :sessions
  resources :users
  
  get "logout"  => "sessions#destroy", :as => "logout"
  get "login"   => "sessions#new", :as => "login"
  get "signup"  => "users#new", :as => "signup"
  
  root :to => 'user/photos#index'
end
