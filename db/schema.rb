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

ActiveRecord::Schema.define(version: 2019_10_14_034918) do

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "image", null: false
    t.string "item_status", null: false
    t.string "delivery_charged", null: false
    t.string "delivery_method", null: false
    t.string "delivery_area", null: false
    t.string "delivery_shipping_date", null: false
    t.integer "total_price"
    t.text "item_profile_comment", null: false
    t.string "item_salse_status", null: false
    t.integer "good"
    t.integer "buyer_id"
    t.integer "seller_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
