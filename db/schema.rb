# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140901023543) do

  create_table "costings", force: true do |t|
    t.string   "foreign_cost"
    t.string   "exchange_rate"
    t.string   "markup"
    t.string   "landed_cost"
    t.integer  "stock_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "costings", ["stock_id"], name: "index_costings_on_stock_id"

  create_table "customers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.string   "item_name"
    t.string   "item_model"
    t.string   "item_serial"
    t.string   "stock_type"
    t.integer  "order_id"
    t.string   "distributor"
    t.string   "manufacturer"
    t.integer  "stock_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["order_id"], name: "index_items_on_order_id"
  add_index "items", ["stock_id"], name: "index_items_on_stock_id"

  create_table "jobs", force: true do |t|
    t.string   "job_number"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "jobs", ["customer_id"], name: "index_jobs_on_customer_id"

  create_table "orders", force: true do |t|
    t.string   "order_number"
    t.date     "shipping_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "order_status"
  end

  create_table "stock_audits", force: true do |t|
    t.integer  "stock_id"
    t.integer  "user_id"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "audit_params", limit: 255
    t.integer  "item_id"
  end

  add_index "stock_audits", ["item_id"], name: "index_stock_audits_on_item_id"
  add_index "stock_audits", ["stock_id"], name: "index_stock_audits_on_stock_id"
  add_index "stock_audits", ["user_id"], name: "index_stock_audits_on_user_id"

  create_table "stocks", force: true do |t|
    t.integer  "serial_number"
    t.integer  "job_id"
    t.string   "detail"
    t.string   "status"
    t.string   "status_detail"
    t.string   "gesan_number"
    t.string   "ppsr"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "needs_ppsr",       default: true
    t.string   "supplier_name"
    t.string   "vin"
    t.date     "shipping_date"
    t.integer  "order_id"
    t.integer  "accounts_signoff"
    t.integer  "projects_signoff"
    t.string   "location"
    t.date     "ppsr_expiry"
  end

  add_index "stocks", ["job_id"], name: "index_stocks_on_job_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.string   "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
