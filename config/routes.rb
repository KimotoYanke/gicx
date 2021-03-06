Rails.application.routes.draw do
  resources :submissions
  get '/submission/pass'
  get '/submission/download'
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :subject
  resources :homeroom
  resources :task
  resources :submission
  get 'home/index'

  root to: 'home#index'
end
