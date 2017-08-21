Rails.application.routes.draw do
  devise_for :users

  resources :sede_queries, path: 'queries'
end
