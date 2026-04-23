Rails.application.routes.draw do
  post 'new', to: 'files#new'
  get 'files/new'
  root 'files#new'
end