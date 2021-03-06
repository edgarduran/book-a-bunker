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

ActiveRecord::Schema.define(version: 20160211032006) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bunkers", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "price"
    t.string   "image",       default: "https://upload.wikimedia.org/wikipedia/commons/0/01/Albania_bunker_2.jpg"
    t.datetime "created_at",                                                                                       null: false
    t.datetime "updated_at",                                                                                       null: false
    t.string   "status"
    t.integer  "bedrooms"
    t.integer  "bathrooms"
    t.integer  "location_id"
    t.integer  "store_id"
  end

  add_index "bunkers", ["location_id"], name: "index_bunkers_on_location_id", using: :btree
  add_index "bunkers", ["store_id"], name: "index_bunkers_on_store_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "order_bunkers", force: :cascade do |t|
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "quantity"
    t.integer  "bunker_id"
  end

  add_index "order_bunkers", ["bunker_id"], name: "index_order_bunkers_on_bunker_id", using: :btree
  add_index "order_bunkers", ["order_id"], name: "index_order_bunkers_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "status"
    t.integer  "store_id"
  end

  add_index "orders", ["store_id"], name: "index_orders_on_store_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.integer  "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "photos", ["item_id"], name: "index_photos_on_item_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "description"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "approved"
  end

  add_index "stores", ["location_id"], name: "index_stores_on_location_id", using: :btree

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_roles", ["role_id"], name: "index_user_roles_on_role_id", using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "store_id"
  end

  add_index "users", ["store_id"], name: "index_users_on_store_id", using: :btree

  add_foreign_key "bunkers", "locations"
  add_foreign_key "bunkers", "stores"
  add_foreign_key "order_bunkers", "bunkers"
  add_foreign_key "order_bunkers", "orders"
  add_foreign_key "orders", "stores"
  add_foreign_key "orders", "users"
  add_foreign_key "photos", "bunkers", column: "item_id"
  add_foreign_key "stores", "locations"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
  add_foreign_key "users", "stores"
end
