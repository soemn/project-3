Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'
  root 'welcome#index'
  # login and register routes ------------------------------------
  # get 'users/new'
  # get 'register' => 'registrations#create'
  # post 'register' => 'devise/sessions#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
