Rails.application.routes.draw do
  devise_for :users

  resources :items do
    collection do
      get 'purchase'
      get 'sell'
      get 'shousai'
    end
  end
  root 'items#index'

  resources :users, only: %i[index update] do
    collection do
      get 'henshuu'
      get "logout"
      get "card"
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

  resources :cards, only: %i[index edit update]
  resources :logouts, only: [:index]

  # S3画像アップロードテスト用のルーティング作成(いずれ削除)
  resources :tests, only: %i[index create]
end
