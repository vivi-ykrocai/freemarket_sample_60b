Rails.application.routes.draw do
  devise_for :users
  resources :items do
    collection do
      get 'purchase'
    end
  end
  root 'items#index'
  
  resources :users, only: [:index, :edit, :update]
    
  resources :cards, only: [:index, :edit, :update]
  resources :logouts, only: [:index]
end
