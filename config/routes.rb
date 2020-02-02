Rails.application.routes.draw do
  

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }
  get '/dashboard' => "user#dashboard"
  post '/users/edit' => "user#update"
  get '/users/:id'  => "user#show"
  get '/selling_orders' => "orders#selling_orders"
  get '/buying_orders' => "orders#buying_orders"
  put '/orders/:id/complete' =>  "orders#complete", as: "order_complete"
  
  get 'pages/home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "pages#home"
  resources :gigs do
    member do
      delete :delete_photo
      post :upload_photo
    end
    resources :orders, only: [:create]
  end
  
end
