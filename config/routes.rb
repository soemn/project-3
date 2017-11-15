Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, path: '', path_names: {
    sign_in: 'login', sign_out: 'logout',
    sign_up: 'register', edit: 'profile/edit'
  }

  get 'welcome/index'
  root 'welcome#index'

  get '/user/:id', to: 'photos#show_profile', as: 'users'

  post '/interactions/new', to: 'interactions#create'

  resources :photos

  # resources :interactions

  resources :brands

  resources :rewards

  get '/test', to: 'brands#test'
end
