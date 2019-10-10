Rails.application.routes.draw do
  devise_for :users
  resources :items
  # マージするときに、root 'items#index'に戻す。
  root 'users#edit'
  resources :users, only: [:index, :edit, :update]
  resources :cards, only: [:index, :edit, :update]
  resources :logouts, only: [:index]
end
