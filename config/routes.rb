Nora::Engine.routes.draw do
  root to: 'top#index'

  resources :repositories

  get 'sign_in', to: 'session#new', as: 'sign_in'
  delete 'sign_out', to: 'session#destroy', as: 'sign_out'
  get 'auth/:provider/callback', to: 'session#create'
end
