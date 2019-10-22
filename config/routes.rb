Rails.application.routes.draw do

  devise_for :users,
  # controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
  #   registrations: 'users/registrations' }

  root 'items#index'


  resources :items do
    member do
      post 'pay'
    end

    collection do
      get 'sell'
      get  'done'
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end

  resources :items do
    member do
      get 'purchase'
      get 'detail'
    end
end


  resources :users, only: [:show, :update] do
    collection do
      get "logout"
      get "card"
      get "identification"
    end
    member do
      get 'profile'
      get 'selling'
      get 'progression'
      get 'completion'
    end
  end

  resources :signup do
    collection do
      get 'sign_up'
      get 'step1'
      get 'step2'
      get 'step3'
      get 'step4'
      get 'finish'
    end
  end

  resources :cards, only: [:index, :edit, :update, :member, :new]
  resources :logouts, only: [:index]

end
