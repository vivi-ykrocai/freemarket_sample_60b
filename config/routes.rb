Rails.application.routes.draw do
  devise_for :users
  root 'tests#index'
  resources :users, only: [:index, :edit, :update]
  resources :cards, only: [:index, :edit, :update]

end
