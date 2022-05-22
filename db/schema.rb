# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_05_21_175344) do
  create_table "cars", force: :cascade do |t|
    t.string "plate"
    t.string "model"
    t.string "brand"
    t.integer "max_load"
    t.integer "year"
    t.integer "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_cars_on_company_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "corporate_name"
    t.string "brand_name"
    t.string "domain"
    t.string "cnpj"
    t.string "address"
    t.integer "freight"
    t.integer "threshold"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "delivery_times", force: :cascade do |t|
    t.integer "min_distance"
    t.integer "max_distance"
    t.integer "days"
    t.integer "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_delivery_times_on_company_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "status"
    t.string "code"
    t.string "receiver_name"
    t.string "delivery_address"
    t.integer "product_id", null: false
    t.integer "company_id", null: false
    t.integer "car_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_orders_on_car_id"
    t.index ["company_id"], name: "index_orders_on_company_id"
    t.index ["product_id"], name: "index_orders_on_product_id"
  end

  create_table "prices", force: :cascade do |t|
    t.integer "min_volume"
    t.integer "max_volume"
    t.integer "min_weight"
    t.integer "max_weight"
    t.integer "value"
    t.integer "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_prices_on_company_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "width"
    t.integer "depth"
    t.integer "weight"
    t.integer "height"
    t.string "address"
    t.string "sku"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transport_companies", force: :cascade do |t|
    t.string "corportate_name"
    t.string "brand_name"
    t.string "email_domain"
    t.string "registration_number"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "kind"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cars", "companies"
  add_foreign_key "companies", "users"
  add_foreign_key "delivery_times", "companies"
  add_foreign_key "orders", "cars"
  add_foreign_key "orders", "companies"
  add_foreign_key "orders", "products"
  add_foreign_key "prices", "companies"
end
