Enerserial::Application.routes.draw do



  get '/users' => 'users#index', :as => :users
  get '/users/:id/set_admin' => 'users#set_admin', :as => :set_user_admin
  devise_for :users
  root 'stocks#index'
  get '/stocks/import' => 'stocks#import', :as => :import_stocks
  post '/stocks/import' => 'stocks#import_file'
  get '/stocks/:id/assign_pm' => 'stocks#assign_pm', :as => :assign_pm_stock
  patch '/stocks/:id/assign_pm' => 'stocks#process_pm', :as => :process_pm_stock

  get '/items/new_floor_item' => 'items#new_floor_item', :as => :new_floor_item
  post '/items' => 'items#create_floor_item', :as => :create_floor_item
  get '/items/floor_stock' => 'items#floor_stock', :as => :items_floor_stock
  get '/items/:id/assign_item' => 'items#assign_item', :as => :assign_item
  patch '/items/:id/assign_item' => 'items#process_item', :as => :process_item
  get '/items/:id/stock/:stock_id/' => 'items#item_stock', :as => :item_stock
  patch '/items/:id/stock/:stock_id/' => 'items#process_item_stock', :as => :process_item_stock
  post '/items/:id/' => 'items#unassign_item', :as => :unassign_item

  get '/orders/:id/bulk_edit_stock' => 'stocks#bulk_edit_stock', :as => :bulk_edit_stock
  get '/orders/:id/bulk_edit_stock' => 'stocks#bulk_process_stock', :as => :bulk_process_stock
  get '/orders/:id/bulk_edit_items' => 'items#bulk_edit_items', :as => :bulk_edit_items
  get '/orders/:id/bulk_edit_items' => 'items#bulk_process_items', :as => :bulk_process_items

  resources :costings, only: [:index, :show, :edit, :update, :destroy]

  resources :orders

  resources :stock_audits

  resources :items, only: [:index, :show, :edit, :update, :destroy]

  resources :stocks do
    resources :items, only: [:new, :create]
    resources :costings, only: [:new, :create]
  end

  resources :customers do
    resources :jobs, only: [:new, :create]
  end

  resources :jobs, only: [:index, :show, :edit, :update, :destroy]

end
