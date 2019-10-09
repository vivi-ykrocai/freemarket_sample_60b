Rails.application.routes.draw do
  devise_for :users
  resources :items
  root 'items#index'
  resources :users, only: [:index, :edit, :update]
  resources :cards, only: [:index, :edit, :update]
  resources :logouts, only: [:index]
end
