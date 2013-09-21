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

ActiveRecord::Schema.define(version: 20130921191815) do

  create_table "kids", force: true do |t|
    t.string   "case_number"
    t.string   "org_prefix"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "missing_city"
    t.string   "missing_state"
    t.string   "missing_county"
    t.string   "missing_country"
    t.date     "missing_date"
    t.integer  "age"
    t.boolean  "thumbnail"
    t.boolean  "poster"
    t.string   "thumbnail_url"
    t.string   "image_url"
    t.string   "aged_photo_url"
    t.boolean  "has_aged_photo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
  end

end
