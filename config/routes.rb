Rails.application.routes.draw do


#   devise_for :users

  resources :items do
    collection do
      get 'purchase'
      get 'sell'
      get 'shousai'
      get  'done'
      post 'pay'
      # post 'pay/:id' => 'items#pay'
      # 今はDBに情報がないため仮置きで 'pay'にしている。
      # 後で 'pay/:id'に修正する。工藤

    end
  end
  root 'items#index'


  resources :users, only: [:index, :update] do
    collection do
      get 'henshuu'
    end

    collection do
      get "logout"
    end

    collection do
      get "card"
    end

    collection do
      get "identification"
    end
  end

  resources :signup do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
      get 'step4'
      get 'finish'
    end
  end

  resources :cards, only: [:index, :edit, :update]
  resources :logouts, only: [:index]

  # S3画像アップロードテスト用のルーティング作成(いずれ削除)
  resources :tests, only: [:index, :create]

end

