Rails.application.routes.draw do 
  devise_for :users #絶対に消しちゃダメ。localhost3000で表示されなくなる。deviseのブラックボックス
  root to: "products#index"
  resources :products, only: [:index, :show, :edit, :update, :new, :create, :destroy] do
  resources :orders, only: [:index, :create]

  root to: 'orders#index'
  resources :orders, only:[:create]
  end
end