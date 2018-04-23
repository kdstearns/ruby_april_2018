Rails.application.routes.draw do
  root 'sessions#index' # set root path to be handled by sessions index method

  resources :users, only: [:create, :show]
  resources :sessions, only: [:create, :destroy]
  resources :posts, only: [:index, :create, :show, :destroy] do
    resources :likes, only: [:create]
  end

# SESSIONS
#   root        GET    /                                      sessions#index
#   sessions    POST   /sessions(.:format)                    sessions#create
#   session     DELETE /sessions/:id(.:format)                sessions#destroy

# USERS
#   users       POST   /users(.:format)                       users#create
#   user        GET    /users/:id(.:format)                   users#show

# POSTS
#   posts       GET    /posts(.:format)                       posts#index
#   posts       POST   /posts(.:format)                       posts#create
#   post        GET    /posts/:id(.:format)                   posts#show
#               DELETE /posts/:id(.:format)                   posts#destroy

# LIKES
#   post_likes  POST   /posts/:post_id/likes(.:format)        likes#create
delete '/posts/:post_id/likes'  =>  'likes#destroy', as: 'post_like'

end