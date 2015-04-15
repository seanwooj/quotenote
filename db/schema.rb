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

ActiveRecord::Schema.define(version: 20150415233302) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "backgrounds", force: :cascade do |t|
    t.boolean  "repeating",          default: false
    t.text     "name"
    t.text     "source_url"
    t.text     "creator"
    t.text     "license_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.decimal  "price"
    t.string   "name"
    t.string   "api_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quote_notes", force: :cascade do |t|
    t.text     "quote_text"
    t.string   "font_family"
    t.string   "quote_author"
    t.integer  "background_id"
    t.boolean  "overlay"
    t.string   "font_color"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "quote_notes", ["background_id"], name: "index_quote_notes_on_background_id", using: :btree

  add_foreign_key "quote_notes", "backgrounds"
end
