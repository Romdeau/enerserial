Enerserial::Application.routes.draw do
  root 'stocks#index'

  get '/engines/new_floor_engine' => 'engines#new_floor_engine', :as => :new_floor_engine
  post 'engines' => 'engines#create_floor_engine', :as => :create_floor_engine
  get '/alternators/new_floor_alternator' => 'alternators#new_floor_alternator', :as => :new_floor_alternator
  post 'alternators' => 'alternators#create_floor_alternator', :as => :create_floor_alternator

  resources :stocks do
    resources :alternators, only: [:new, :create]
    resources :engines, only: [:new, :create]
  end

  resources :customers do
    resources :jobs, only: [:new, :create]
  end

  resources :jobs, only: [:index, :show, :edit, :update, :destroy]

  resources :alternators, only: [:index, :show, :edit, :update, :destroy]

  resources :engines, only: [:index, :show, :edit, :update, :destroy]




  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
