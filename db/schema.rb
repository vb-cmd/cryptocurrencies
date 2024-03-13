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

ActiveRecord::Schema[7.1].define(version: 2023_10_12_122450) do
  create_table "coin_histories", force: :cascade do |t|
    t.integer "coin_id"
    t.decimal "price"
    t.datetime "date"
    t.index ["coin_id"], name: "index_coin_histories_on_coin_id"
  end

  create_table "coins", force: :cascade do |t|
    t.integer "rank"
    t.string "symbol"
    t.string "short_name", null: false
    t.string "full_name"
    t.decimal "market_cap"
    t.decimal "price"
    t.decimal "change_24h"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
