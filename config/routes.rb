Enerserial::Application.routes.draw do

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
  get '/items/floor_stock' => 'items#floor_stock', :as => :items_floor_stock
  get '/items/:id/alternator_assign' => 'items#assign_alternator', :as => :assign_item
  patch '/items/:id/alternator_assign' => 'items#process_alternator', :as => :process_item
  patch '/items/:id/alternator_unassign' => 'items#unassign_alternator', :as => :unassign_item

  resources :orders

  resources :stock_audits

  resources :items, only: [:index, :show, :edit, :update, :destroy]

  resources :stocks do
    resources :alternators, only: [:new, :create]
    resources :engines, only: [:new, :create]
    resources :items, only: [:new, :create]
  end

  resources :customers do
    resources :jobs, only: [:new, :create]
  end

  resources :jobs, only: [:index, :show, :edit, :update, :destroy]

  resources :alternators, only: [:index, :show, :edit, :update, :destroy]

  resources :engines, only: [:index, :show, :edit, :update, :destroy]

end
