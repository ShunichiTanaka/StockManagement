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

ActiveRecord::Schema.define(version: 20170714140517) do

  create_table "brands", force: :cascade do |t|
    t.string   "name",       limit: 255,   null: false
    t.integer  "code",       limit: 4,     null: false
    t.text     "info",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "fields", force: :cascade do |t|
    t.string   "name",       limit: 255,   null: false
    t.text     "info",       limit: 65535, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "markets", force: :cascade do |t|
    t.string   "name",       limit: 255,   null: false
    t.text     "info",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "stock_accounts", force: :cascade do |t|
    t.integer  "user_id",          limit: 4,                 null: false
    t.integer  "stock_company_id", limit: 4,                 null: false
    t.integer  "assets_sum",       limit: 4,     default: 0, null: false
    t.text     "info",             limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "stock_companies", force: :cascade do |t|
    t.string   "name",       limit: 255,   null: false
    t.text     "info",       limit: 65535, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "stock_prices", force: :cascade do |t|
    t.date     "target_date",                     null: false
    t.integer  "code",                 limit: 4,  null: false
    t.integer  "market_id",            limit: 4,  null: false
    t.integer  "open",                 limit: 4,  null: false
    t.integer  "high",                 limit: 4,  null: false
    t.integer  "low",                  limit: 4,  null: false
    t.integer  "close",                limit: 4,  null: false
    t.integer  "trading_value",        limit: 8,  null: false
    t.integer  "previous_price",       limit: 4
    t.float    "previous_price_ratio", limit: 24
    t.float    "twenty_average",       limit: 24
    t.float    "standard_deviation",   limit: 24
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "stock_prices", ["target_date", "code"], name: "index_stock_prices_on_target_date_and_code", using: :btree

  create_table "trading_histories", force: :cascade do |t|
    t.date     "purchase_date",            null: false
    t.integer  "code",           limit: 4, null: false
    t.integer  "purchase_price", limit: 4, null: false
    t.integer  "stock_number",   limit: 4, null: false
    t.date     "disposal_date"
    t.integer  "disposal_price", limit: 4
    t.integer  "profit",         limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255,              null: false
    t.integer  "role",                   limit: 4,   default: 0,  null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "failed_attempts",        limit: 4,   default: 0,  null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
