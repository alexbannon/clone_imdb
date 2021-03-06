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

ActiveRecord::Schema.define(version: 20180426171136) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "celebrities", force: :cascade do |t|
    t.string "name", null: false
    t.string "photo_url", null: false
    t.string "profile_url", null: false
    t.bigint "media_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "birth_month"
    t.integer "birth_day"
    t.index ["media_id"], name: "index_celebrities_on_media_id"
  end

  create_table "media", force: :cascade do |t|
    t.string "title", null: false
    t.string "url", null: false
    t.float "rating", default: 0.0
    t.string "director", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
