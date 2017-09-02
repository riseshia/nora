Nora::Engine.routes.draw do
  root to: 'top#index'

  resources :repositories

  get 'sign_in', to: 'sessions#new', as: 'sign_in'
  delete 'sign_out', to: 'sessions#destroy', as: 'sign_out'
  get 'auth/:provider/callback', to: 'sessions#create'
end
