Rails.application.routes.draw do
  devise_for :users
  resources :items
  root 'items#index'

  resources :users, only: [:index, :edit, :update] do
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
end
