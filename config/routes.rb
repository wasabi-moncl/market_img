MarketImg::Application.routes.draw do
  match 'banners/import' => 'banners#import', :via => :post  
  match 'photos_write_all' => 'photos#write_all', :via => :get
  match 'product_image/:id' => 'user/items#product_image', :via => :get, :as => "product_image"
  
  get "logout"  => "sessions#destroy", :as => "logout"
  get "login"   => "sessions#new", :as => "login"
  get "signup"  => "users#new", :as => "signup"
  
  resources :sessions
  resources :users
  resources :positions
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

  resources :templates do
    member { get :composed_image }
    scope :module => "template" do
      resources :photos
    end
    resources :labels do
      collection { get :update_all}
    end
  end

  root :to => 'user/photos#index'
end