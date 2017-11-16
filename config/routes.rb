Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login', sign_out: 'logout',
    sign_up: 'register', edit: 'profile/edit'
  }

  root 'welcome#index'

  get '/user/:id', to: 'photos#show_profile', as: 'users'

  post '/interactions/new', to: 'interactions#create'
  post '/interactions/like', to: 'interactions#like'

  resources :photos

  resources :brands

  resources :rewards, only: %i[index new create]

  get '/rewards/redeem', to: 'rewards#redeem'

  get '/test', to: 'brands#test'
end
