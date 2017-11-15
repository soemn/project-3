Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, path: '', path_names: {
    sign_in: 'login', sign_out: 'logout',
    sign_up: 'register', edit: 'profile/edit'
  }

  # get 'welcome/index'
  root 'welcome#index'

  resources :photos

  # resources :interactions

  resources :brands

  get 'interaction/new', to: 'photo#new_interaction'
end
