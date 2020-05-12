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

ActiveRecord::Schema.define(version: 2020_05_09_030403) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "address_workers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "addresses", force: :cascade do |t|
    t.string "line1", null: false
    t.string "line2"
    t.string "city", null: false
    t.string "state", null: false
    t.string "country", null: false
    t.integer "zipcode", null: false
    t.bigint "user_id"
    t.float "latitude"
    t.float "longitude"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_id"
    t.bigint "food_item_id"
    t.integer "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["food_item_id"], name: "index_cart_items_on_food_item_id"
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "consumer_id"
    t.bigint "restaurant_id"
    t.integer "order_status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consumer_id"], name: "index_carts_on_consumer_id"
    t.index ["restaurant_id"], name: "index_carts_on_restaurant_id"
  end

  create_table "consumers", force: :cascade do |t|
  end

  create_table "food_items", force: :cascade do |t|
    t.string "name", null: false
    t.integer "price", null: false
    t.string "description"
  end

  create_table "food_items_menus", force: :cascade do |t|
    t.bigint "menu_id"
    t.bigint "food_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_item_id"], name: "index_food_items_menus_on_food_item_id"
    t.index ["menu_id"], name: "index_food_items_menus_on_menu_id"
  end

  create_table "menus", force: :cascade do |t|
    t.integer "meal_category", default: 0, null: false
    t.bigint "restaurant_id"
    t.index ["restaurant_id"], name: "index_menus_on_restaurant_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "cart_id"
    t.integer "status", default: 0, null: false
    t.bigint "restaurant_id"
    t.bigint "consumer_id"
    t.index ["cart_id"], name: "index_orders_on_cart_id"
    t.index ["consumer_id"], name: "index_orders_on_consumer_id"
    t.index ["restaurant_id"], name: "index_orders_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.decimal "delivery_range"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "order_id"
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_reviews_on_order_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "entity_type"
    t.bigint "entity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "contact_no"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["entity_type", "entity_id"], name: "index_users_on_entity_type_and_entity_id"
  end

  create_table "working_hours", force: :cascade do |t|
    t.date "day", null: false
    t.time "start_time", null: false
    t.time "end_time", null: false
    t.integer "status", default: 0, null: false
    t.bigint "restaurant_id"
    t.index ["day"], name: "index_working_hours_on_day", unique: true
    t.index ["restaurant_id"], name: "index_working_hours_on_restaurant_id"
  end

end
