Shopper::Application.routes.draw do
  root :to => "products#index"

  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  match "/mine" => "products#user_products", :as => :user_products
  
  resources :products
end
