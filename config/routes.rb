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
  resources :comments
  resources :statics

  resources :news do
    resources :comments
  end

  # API
  namespace :api, defaults: { format: :json } do
    get 'markers', to: 'markers#show'
  end

  get 'profile', to: 'users#profile'

  match '/:url', url: /.*/, constraints: { url: /((?!assets)\w.+)+/ }, to: 'statics#display', via: :get
end
