Rails.application.routes.draw do
  mount RedactorRails::Engine => '/redactor_rails'

  # You can have the root of your site routed with "root"
  root 'map#index'

  # Authorization
  devise_for :users, path: '', path_names: {
    sign_in: 'login', 
    sign_out: 'logout', 
    password: 'reset_password'
  }

  # Resources
  resources :statics
  resources :comments, only: [:create]

  resources :news do
    resources :comments
  end

  # API
  namespace :api, defaults: { format: :json } do
    get 'markers', to: 'markers#show'
  end

  # Admin
  namespace :admin do
    resources :news, except: [:show]
    resources :users, except: [:show]
    resources :comments, except: [:new, :create, :show]
  end

  get 'profile', to: 'users#profile'
  get 'profile/edit', to: 'users#edit'
  patch 'profile/update', to: 'users#update'

  match '/:url', url: /.*/, constraints: { url: /((?!assets)\w.+)+/ }, to: 'statics#display', via: :get
end
