Rails.application.routes.draw do
  devise_for :users

  scope 'queries' do
    root               to: 'sede_queries#index',   as: :sede_queries
    get    'new',      to: 'sede_queries#new',     as: :new_sede_query
    post   'new',      to: 'sede_queries#create',  as: :create_sede_query
    get    ':id/edit', to: 'sede_queries#edit',    as: :edit_sede_query
    patch  ':id/edit', to: 'sede_queries#update',  as: :update_sede_query
    get    ':id',      to: 'sede_queries#show',    as: :sede_query
    delete ':id',      to: 'sede_queries#destroy', as: :destroy_sede_query
  end
end
