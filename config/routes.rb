Rails.application.routes.draw do


#   devise_for :users
  root 'items#index'
  resources :items do
    collection do
      get 'purchase'
      get 'sell'
    end
  end

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
      get 'sign_in'
      get 'sign_up'
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

