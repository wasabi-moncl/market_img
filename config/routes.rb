MarketImg::Application.routes.draw do
  resources :sessions
  resources :users
  
  get "logout"  => "sessions#destroy", :as => "logout"
  get "login"   => "sessions#new", :as => "login"
  get "signup"  => "users#new", :as => "signup"
  
  root :to => 'sessions#new'
end
