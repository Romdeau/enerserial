Enerserial::Application.routes.draw do

  resources :items

  get '/users' => 'users#index', :as => :users
  get '/users/:id/set_admin' => 'users#set_admin', :as => :set_user_admin
  devise_for :users
  root 'stocks#index'
  get '/stocks/import' => 'stocks#import', :as => :import_stocks
  post '/stocks/import' => 'stocks#import_file'
  get '/stocks/:id/assign_pm' => 'stocks#assign_pm', :as => :assign_pm_stock
  patch '/stocks/:id/assign_pm' => 'stocks#process_pm', :as => :process_pm_stock

  get '/engines/new_floor_engine' => 'engines#new_floor_engine', :as => :new_floor_engine
  post '/engines' => 'engines#create_floor_engine', :as => :create_floor_engine
  get '/engines/floor_stock' => 'engines#floor_stock', :as => :engines_floor_stock
  get '/engines/:id/engine_assign' => 'engines#assign_engine', :as => :assign_engine
  patch '/engines/:id/engine_assign' => 'engines#process_engine', :as => :process_engine
  patch '/engines/:id/engine_unassign' => 'engines#unassign_engine', :as => :unassign_engine

  get '/alternators/new_floor_alternator' => 'alternators#new_floor_alternator', :as => :new_floor_alternator
  post '/alternators' => 'alternators#create_floor_alternator', :as => :create_floor_alternator
  get '/alternators/floor_stock' => 'alternators#floor_stock', :as => :alternators_floor_stock
  get '/alternators/:id/alternator_assign' => 'alternators#assign_alternator', :as => :assign_alternator
  patch '/alternators/:id/alternator_assign' => 'alternators#process_alternator', :as => :process_alternator
  patch '/alternators/:id/alternator_unassign' => 'alternators#unassign_alternator', :as => :unassign_alternator

  get '/items/new_floor_alternator' => 'items#new_floor_alternator', :as => :new_floor_item
  post '/items' => 'items#create_floor_alternator', :as => :create_floor_item
  get '/items/floor_stock' => 'items#floor_stock', :as => :item_floor_stock
  get '/items/:id/alternator_assign' => 'items#assign_alternator', :as => :assign_item
  patch '/items/:id/alternator_assign' => 'items#process_alternator', :as => :process_item
  patch '/items/:id/alternator_unassign' => 'items#unassign_alternator', :as => :unassign_item

  resources :orders

  resources :stock_audits

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
