Rails.application.routes.draw do

  devise_for :users
  root 'items#index'

  resources :items do
    collection do
      get 'sell'
      get  'done'
      post 'pay'
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end

  resources :items do
    member do
      get :purchase
    end
end



  resources :users, only: [:index, :update] do
    collection do
      get 'henshuu'
      get "logout"
      get "card"
      get "identification"
      get 'selling'
      get 'progression'
      get 'completion'
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
