Rails.application.routes.draw do
  devise_for :users
  root to: 'sede_queries#index'

  scope 'queries' do
    root                to: 'sede_queries#index',   as: :sede_queries
    get    'new',       to: 'sede_queries#new',     as: :new_sede_query
    post   'new',       to: 'sede_queries#create',  as: :create_sede_query
    get    ':id/edit',  to: 'sede_queries#edit',    as: :edit_sede_query
    patch  ':id/edit',  to: 'sede_queries#update',  as: :update_sede_query
    post   ':id/fetch', to: 'sede_queries#fetch',   as: :fetch_sede_query
    get    ':id',       to: 'sede_queries#show',    as: :sede_query
    delete ':id',       to: 'sede_queries#destroy', as: :destroy_sede_query
  end

  scope 'review' do
    post 'submit', to: 'review#submit_result', as: :submit_review
    get  ':query_id',    to: 'review#review_query',  as: :review_sede_query
  end
end
