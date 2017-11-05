Rails.application.routes.draw do
  # login and register routes ------------------------------------
  # get 'users/new'
  get 'register' => 'users#new'
  post 'register' => 'users#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
