Nora::Engine.routes.draw do
  root to: 'top#index'

  resources :hooks, only: %i[create]
  resources :repositories, only: %i[index new create destroy]
  resources :executions, only: %i[index show new create destroy]

  get 'sign_in', to: 'session#new', as: 'sign_in'
  delete 'sign_out', to: 'session#destroy', as: 'sign_out'
  get 'auth/:provider/callback', to: 'session#create'
end
