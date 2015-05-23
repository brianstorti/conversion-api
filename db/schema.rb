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

ActiveRecord::Schema.define(version: 20150523141703) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conversions", force: :cascade do |t|
    t.integer "metric_id"
    t.integer "start_date"
    t.integer "time_range_length"
    t.integer "end_date"
    t.decimal "value"
    t.integer "last_calculated_at"
  end

  add_index "conversions", ["end_date"], name: "index_conversions_on_end_date", using: :btree
  add_index "conversions", ["metric_id"], name: "index_conversions_on_metric_id", using: :btree
  add_index "conversions", ["start_date"], name: "index_conversions_on_start_date", using: :btree
  add_index "conversions", ["time_range_length"], name: "index_conversions_on_time_range_length", using: :btree

end
