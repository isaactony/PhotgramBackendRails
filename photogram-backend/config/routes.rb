Rails.application.routes.draw do
  resources :likes
  #resources :followers
  resources :posts
  resources :users
  
  # resources :posts do
  #   resources :comments, only: [:create, :update, :destroy]
  # end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/users/search', to: 'users#search'
  get '/logged_user', to: 'users#logged_user'
  get "/logged_in", to: "sessions#logged_in"
  patch '/posts/:id/comments', to: 'posts#update_comments'


  # post "/login", to: "sessions#login"
  # delete "/logout", to: "sessions#logout"

  root to: 'posts#index'
  
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  delete "/logout", to: "sessions#logout"

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  #delete '/logout', to: 'sessions#destroy'

  # resources :posts do
  #   resources :comments, only: [:create, :update, :destroy]
  # end

  #route for editing user profile
  resources :users, only: [:edit, :update]
#will uncomment this
  resources :users do
    member do
      post :follow
      delete :unfollow
      get :followers
      get :following
    end
  end
  
  # resources :posts do
  #   resources :comments, only: [:create, :index, :update]
  #   resources :likes, only: [:create]
  # end
  
  # resources :posts, only: [:index, :show, :new, :create, :destroy] do
  #   resources :likes, only: [:create]
  # end
  
  resources :users, only: [:show] do
    member do
      get :following, :followers
    end
  end
  
   #added
   get '/users/:username', to: 'users#show'

   # Fetch post information
   get '/posts/:id', to: 'posts#show'
 
   # Fetch likes for the post
   get '/posts/:id/likes', to: 'likes#index'
 
   # Fetch like count for the post
   get '/posts/:id/likes/count', to: 'likes#count'
 
  
  #  root to: 'posts#index'
  
   get '/signup', to: 'users#new'
   post '/signup', to: 'users#create'
   
  # resource :profile, only: [:edit, :update]
  # get '/profile/edit', to: 'profiles#edit', as: 'edit_profile'

  # # Update profile action
  # patch '/profile', to: 'profiles#update', as: 'update_profile'

   #added for login
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'


  patch '/users/:id', to: 'users#update'

  resources :users, only: [:edit, :update]
  # get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
  
  # # Custom route for updating a user
  # patch '/users/:id', to: 'users#update', as: 'update_user'
end
