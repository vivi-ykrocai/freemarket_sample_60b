Rails.application.routes.draw do
  devise_for :users
  # マージするときに、root 'items#index'に戻す。
  # root 'users#edits'
  resources :items do
    collection do
      get 'purchase'
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

  resources :cards, only: [:index, :edit, :update]
  resources :logouts, only: [:index]
end
