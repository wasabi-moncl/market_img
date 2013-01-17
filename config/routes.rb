MarketImg::Application.routes.draw do

  match 'store/:username/:item_code/item' => 'user/items#html_code', :via => :get, :as => "html_code"
  match 'templates/:template_id/test_page/:item_code' => 'user/items#test_page', :via => :get, :as => "test_page"
  match 'product_image/:id' => 'user/items#product_image', :via => :get, :as => "product_image"
  match 'saved_image/:id' => 'user/items#saved_image', :via => :get, :as => "saved_image"
  get "dashboard" => "user/dashboard#index", :via => :get, :as => "dashboard" 
  get "logout"  => "sessions#destroy", :as => "logout"
  get "login"   => "sessions#new", :as => "login"
  get "signup"  => "users#new", :as => "signup"

  resources :sessions
  resources :users
  resources :branches
  resources :brand_categories
  resources :brands
  resources :photos, :only => [:index, :edit, :destroy]
  
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
        collection do
          get :example_image
          get :annotated_example_image
        end
      end
      resources :photos
    end
  end
  
  resources :positions do
    scope :module => "position" do
      resources :labels do
        collection {get :example_image}
      end
    end
  end
  
  root :to => 'sessions#new'
end