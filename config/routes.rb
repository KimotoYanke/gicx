Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :subject
  resources :homeroom
  resources :task
  resources :submission
  get 'home/index'

  root to: 'home#index'
end
