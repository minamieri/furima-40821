Rails.application.routes.draw do #このブロックの中で、アプリケーションのルーティングを定義
  devise_for :users  # ユーザー登録、ログイン、ログアウト、パスワードリセットなどのURLルートを自動的に生成。ユーザー認証に関連するルートが簡単に設定される。
  # get 'articles/index' # HTTP GETリクエストが /articles/index というパスに送信されたときに、ArticlesController の index アクションが実行されるようにします
  # root to: "articles#index" 
  #トップページ）を設定。アプリケーションのホームページとして articles#index が使用される。
  root to: "products#index"
  resources :products do
    resources :shippings, only: [:new, :create] 
  end
end
