Rails.application.routes.draw do
  

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }
  get '/dashboard' => "user#dashboard"
  post '/users/edit' => "user#update"
  get '/users/:id'  => "user#show"
  
  get 'pages/home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "pages#home"
  resources :gigs do
    member do
      delete :delete_photo
      post :upload_photo
    end
  end
  
end
