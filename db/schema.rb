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

ActiveRecord::Schema.define(version: 20140711012001) do

  create_table "alternators", force: true do |t|
    t.integer  "stock_id"
    t.string   "alternator"
    t.string   "alternator_type"
    t.string   "serial"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "engines", force: true do |t|
    t.integer  "stock_id"
    t.string   "engine"
    t.string   "engine_type"
    t.string   "serial"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", force: true do |t|
    t.string   "job_number"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "jobs", ["customer_id"], name: "index_jobs_on_customer_id"

  create_table "orders", force: true do |t|
    t.string   "order_number"
    t.date     "shipping_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stock_audits", force: true do |t|
    t.integer  "stock_id"
    t.integer  "engine_id"
    t.integer  "alternator_id"
    t.integer  "user_id"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "audit_params"
  end

  add_index "stock_audits", ["alternator_id"], name: "index_stock_audits_on_alternator_id"
  add_index "stock_audits", ["engine_id"], name: "index_stock_audits_on_engine_id"
  add_index "stock_audits", ["stock_id"], name: "index_stock_audits_on_stock_id"
  add_index "stock_audits", ["user_id"], name: "index_stock_audits_on_user_id"

# Could not dump table "stocks" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
