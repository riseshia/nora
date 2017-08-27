Rails.application.routes.draw do
  get 'nora/webhook/auth/:provider', to: 'nora/sessions#create'
end
