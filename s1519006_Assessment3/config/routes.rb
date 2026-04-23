Rails.application.routes.draw do
  root "articles#index"
  get "/articles", to: "articles#index"
  get "/articles", to: "articles#show"
  get "/articles/news"
  get '/articles/adminlog', to: "articles#adminlog"

  post 'search', to: 'articles#search'
  get 'articles/search'

  post 'login', to: 'articles#login'
  get 'articles/login'

  get '/admin', to: "articles#admin"

  get 'articles/hide'

  get 'articles/editA'
  get 'articles/updateA'
  get 'articles/newA'
  get 'articles/removeA'

  get 'articles/editC'
  get 'articles/newC'
  get 'articles/removeC'

  resources :articles

  resources :articles do
    resources :comments
    resources :genres
  end

  resources :genres do
    resources :articles
  end
end
