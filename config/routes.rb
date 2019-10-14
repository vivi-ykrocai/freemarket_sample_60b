Rails.application.routes.draw do
  'routes#index'
  resources :signup do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
      get 'step4' 
      get 'finish' 
    end
  end
end

