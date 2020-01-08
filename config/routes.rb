Rails.application.routes.draw do
  get '/dashboard' => "user#dashboard"
  post '/users/edit' => "user#update"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }
  get 'pages/home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "pages#home"
  
end
