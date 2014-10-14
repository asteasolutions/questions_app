Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  current_api_routes = lambda do
    devise_for :users, skip: [:confirmations]

    resources :questions, only: [:show, :index, :create] do
      resources :answers, only: [:show, :index, :create]
    end
  end

  namespace :api, defaults: {format: 'json'} do
    namespace :v1, &current_api_routes

    # match ":api/*path", :to => redirect("/api/v1/%{path}")
  end

  current_api_routes.call()

  # You can have the root of your site routed with "root"
  root 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  #
  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
