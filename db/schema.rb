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

ActiveRecord::Schema.define(version: 20130929225021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "afterparty_jobs", force: true do |t|
    t.text     "job_dump"
    t.string   "queue"
    t.datetime "execute_at"
    t.boolean  "completed"
    t.boolean  "has_error"
    t.text     "error_message"
    t.text     "error_backtrace"
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kid_locations", force: true do |t|
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer  "views"
    t.integer  "height"
    t.integer  "weight"
    t.string   "eye_color"
    t.string   "hair_color"
    t.string   "race"
    t.string   "sex"
    t.text     "circumstance"
  end

  create_table "request_locations", force: true do |t|
    t.string   "ip_address"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
