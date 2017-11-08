Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, path: '', path_names: {
    sign_in: 'login', sign_out: 'logout',
    sign_up: 'register', edit: 'profile/edit'
  }

  # get 'welcome/index'
  root 'welcome#index'

  resources :photos
  # login and register routes ------------------------------------
  # get 'users/new'
  # get 'register' => 'registrations#create'
  # post 'register' => 'devise/sessions#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
