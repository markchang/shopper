Shopper::Application.routes.draw do
  root :to => "products#index"

  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  
  resources :products
end
