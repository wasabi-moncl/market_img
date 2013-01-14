MarketImg::Application.routes.draw do


  resources :elements

  resources :branches

  resources :brand_categories

  resources :brands

  match 'banners/import' => 'banners#import', :via => :post  
  match 'photos_write_all' => 'photos#write_all', :via => :get
  match 'product_image/:id' => 'user/items#product_image', :via => :get, :as => "product_image"
  match 'saved_image/:id' => 'user/items#saved_image', :via => :get, :as => "saved_image"
  match 'brands/:id/:item_code' => 'templates#html_code', :via => :get, :as => "html_code"
  get "dashboard" => "user/dashboard#index", :via => :get, :as => "dashboard" 
  get "logout"  => "sessions#destroy", :as => "logout"
  get "login"   => "sessions#new", :as => "login"
  get "signup"  => "users#new", :as => "signup"
  
  resources :photos, :only => [:index, :edit, :destroy]
  resources :sessions
  resources :users
  resources :positions

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
    scope :module => "template" do
      resources :molds
      resources :elements
      resources :photos
    end
    member do
      get :composed_image
    end
    resources :labels do
      collection { get :update_all}
    end    
  end
  
  resources :molds do
    scope :module => "mold" do
      resources :positions do
        collection { get :example_image}
      end
      resources :photos
    end
  end
  
  root :to => 'sessions#new'
end