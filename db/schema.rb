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

ActiveRecord::Schema.define(version: 20140318004902) do

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

  create_table "stocks", force: true do |t|
    t.integer  "serial_number"
    t.integer  "job_id"
    t.string   "detail"
    t.string   "status"
    t.string   "status_detail"
    t.string   "gesan_number"
    t.integer  "ppsr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stocks", ["job_id"], name: "index_stocks_on_job_id"

end
