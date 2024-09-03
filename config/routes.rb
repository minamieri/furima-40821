Rails.application.routes.draw do 
  devise_for :users #絶対に消しちゃダメ。localhost3000で表示されなくなる。deviseのブラックボックス
  root to: "products#index"
  resources :products, only: [:index, :show, :new]
end
