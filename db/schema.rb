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

ActiveRecord::Schema.define(version: 20131219234423) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_items", force: true do |t|
    t.integer  "quantity"
    t.integer  "product_id"
    t.integer  "order_id"
    t.integer  "price"
    t.integer  "subtotal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",          default: "pending"
    t.integer  "user_id"
    t.string   "email"
    t.string   "mailing_address"
    t.string   "name_on_cc"
    t.integer  "cc_number"
    t.integer  "cc_expiration"
    t.integer  "cc_cvv"
    t.integer  "billing_zip"
  end

  create_table "product_to_category_relationships", force: true do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.text     "name"
    t.text     "description"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id"
    t.string   "image"
    t.integer  "stock"
    t.boolean  "retired",     default: false
  end

  create_table "reviews", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.boolean  "authenticated"
    t.string   "email"
    t.boolean  "merchant"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.string   "password"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
