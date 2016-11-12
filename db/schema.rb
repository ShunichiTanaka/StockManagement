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

ActiveRecord::Schema.define(version: 20161112124739) do

  create_table "brands", force: :cascade do |t|
    t.string   "name",       limit: 255,   null: false
    t.integer  "code",       limit: 4,     null: false
    t.integer  "field_id",   limit: 4,     null: false
    t.integer  "market_id",  limit: 4,     null: false
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
    t.text     "info",       limit: 65535, null: false
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

  create_table "trades", force: :cascade do |t|
    t.integer  "stock_account_id", limit: 4,     null: false
    t.integer  "brand_id",         limit: 4,     null: false
    t.integer  "status",           limit: 4,     null: false
    t.date     "trade_at",                       null: false
    t.integer  "contract_price",   limit: 4,     null: false
    t.integer  "trade_sum",        limit: 4,     null: false
    t.integer  "sales_price",      limit: 4,     null: false
    t.integer  "charges",          limit: 4,     null: false
    t.date     "payment_at"
    t.integer  "payment_price",    limit: 4
    t.float    "profit_ratio",     limit: 24
    t.text     "info",             limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255,             null: false
    t.string   "pass",       limit: 255,             null: false
    t.integer  "role",       limit: 4,   default: 0, null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

end
