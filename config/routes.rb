Rails.application.routes.draw do
  root to: 'nora/top#index'

  namespace :nora do
    get 'top/index'

    get 'sessions/new'
    get 'sessions/create'
    get 'sessions/destroy'
  end

  get 'sign_in', to: 'nora/sessions#new', as: 'sign_in'
  delete 'sign_out', to: 'nora/sessions#destroy', as: 'sign_out'

  get 'auth/:provider/callback', to: 'nora/sessions#create'
end
