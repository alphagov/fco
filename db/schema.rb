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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111101161517) do

  create_table "countries", :force => true do |t|
    t.string "name"
    t.string "fco_id"
    t.string "iso_3166_2"
    t.string "slug"
    t.string "essential_travel_restriction"
    t.string "avoid_travel_restriction"
    t.text   "raw_travel_advice",            :limit => 2147483647
  end

  add_index "countries", ["slug"], :name => "index_countries_on_slug", :unique => true

  create_table "missions", :force => true do |t|
    t.string  "country_fco_id"
    t.string  "fco_id"
    t.string  "email"
    t.string  "url"
    t.string  "designation"
    t.string  "location_name"
    t.string  "phone"
    t.text    "address"
    t.text    "office_hours"
    t.decimal "latitude",       :precision => 15, :scale => 10
    t.decimal "longitude",      :precision => 15, :scale => 10
  end

  add_index "missions", ["fco_id"], :name => "index_missions_on_fco_id"

  create_table "travel_news", :force => true do |t|
    t.text     "body_plain"
    t.text     "body_markup"
    t.text     "description"
    t.string   "title"
    t.string   "url"
    t.string   "slug"
    t.datetime "published_at"
  end

end
