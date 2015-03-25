Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'map#index'

  namespace :api do
    namespace :mbta do
      resources :modes, only: [:index]
      resources :routes, only: [:show], param: :mode
      resources :positions, only: [:show, :index], param: :route
    end
  end
end
