Rails.application.routes.draw do 
  root to: "products#index"
  resources :products do
    resources :shippings, only: [:new, :create] 
  end
end
