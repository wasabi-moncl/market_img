MarketImg::Application.routes.draw do
  resources :positions

  resources :templates do
    scope :module => "template" do
      resources :photos
    end
  end

  resources :banners
  resources :items do
    resources :photos
  end
  
  namespace :user do
    resources :photos
    resources :items do
      collection { post :import }
    end
  end
  
  resources :sessions
  resources :users
  
  match 'banners/import' => 'banners#import', :via => :post  
  match 'photos_write_all' => 'photos#write_all', :via => :get
  match 'product_image/:id' => 'user/items#product_image', :via => :get, :as => "product_image"
  
  get "logout"  => "sessions#destroy", :as => "logout"
  get "login"   => "sessions#new", :as => "login"
  get "signup"  => "users#new", :as => "signup"
  
  root :to => 'user/photos#index'
end
