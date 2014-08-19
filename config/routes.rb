Enerserial::Application.routes.draw do

  get '/jobs/:id/assign_pm' => 'jobs#assign_pm', :as => :assign_pm_job
  patch '/jobs/:id/assign_pm' => 'jobs#process_pm', :as => :process_pm_job
  get '/jobs/:id/change_customer' => 'jobs#change_customer', :as => :change_customer_job
  get '/jobs/:id/change_customer/:customer_id/' => 'jobs#customer_job', :as => :customer_job
  patch '/jobs/:id/change_customer/:customer_id/' => 'jobs#process_customer_job', :as => :process_customer_job

  get '/users' => 'users#index', :as => :users
  get '/users/:id/edit_role' => 'users#edit_role', :as => :edit_user_role
  patch 'users/:id/edit_role' => 'users#update_role', :as => :update_user_role
  get '/users/:id/set_admin' => 'users#set_admin', :as => :set_user_admin
  devise_for :users

  root 'stocks#index'
  get '/stocks/import' => 'stocks#import', :as => :import_stocks
  post '/stocks/import' => 'stocks#import_file'
  get '/stocks/:id/accounts_signoff' => 'stocks#accounts_signoff', :as => :accounts_signoff
  get '/stocks/:id/projects_signoff' => 'stocks#projects_signoff', :as => :projects_signoff

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

  #filtered views
  get '/stocks/filter/:stock_status' => 'stocks#status_filter', :as => :filter_stock_status
  get '/orders/filter/:order_status' => 'orders#status_filter', :as => :filter_order_status

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
