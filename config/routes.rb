MarketImg::Application.routes.draw do


  resources :elements

  resources :branches

  resources :brand_categories

  resources :brands

  match 'banners/import' => 'banners#import', :via => :post  
  match 'photos_write_all' => 'photos#write_all', :via => :get
  match 'product_image/:id' => 'user/items#product_image', :via => :get, :as => "product_image"
  match 'saved_image/:id' => 'user/items#saved_image', :via => :get, :as => "saved_image"
  get "dashboard" => "user/dashboard#index", :via => :get, :as => "dashboard" 
  get "logout"  => "sessions#destroy", :as => "logout"
  get "login"   => "sessions#new", :as => "login"
  get "signup"  => "users#new", :as => "signup"
  
  resources :sessions
  resources :users
  resources :positions
  # resources :banners

  resources :items do
    resources :photos
  end
  
  namespace :user do
    resources :photos do
      collection { post :update_all }
    end
    resources :items do
      collection do 
        post :import
        get :first
      end
    end
  end

  resources :templates do
    member { get :composed_image }
    resources :labels do
      collection { get :update_all}
    end
    scope :module => "template" do
      resources :molds
      resources :elements
      resources :photos
    end
    
  end
  
  resources :molds
  resources :elements
  
  root :to => 'sessions#new'
end