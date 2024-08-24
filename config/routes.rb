Rails.application.routes.draw do
  get 'current_user', to: 'current_user#index'
  get 'search', to: 'products#search'
  
  resource :cart, only: [:show] do
    post 'add_product', to: 'carts#add_product'
    delete 'remove_product', to: 'carts#remove_product'
    post 'checkout', to: 'carts#checkout'
  end

  resources :products do
    resources :comments, only: [:index, :create]
  end

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
