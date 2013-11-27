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

ActiveRecord::Schema.define(version: 20131127042251) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "prosperity_dashboard_views", force: true do |t|
    t.integer  "view_id",      null: false
    t.integer  "dashboard_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prosperity_dashboard_views", ["dashboard_id"], name: "index_prosperity_dashboard_views_on_dashboard_id", using: :btree
  add_index "prosperity_dashboard_views", ["view_id"], name: "index_prosperity_dashboard_views_on_view_id", using: :btree

  create_table "prosperity_dashboards", force: true do |t|
    t.string   "title",      null: false
    t.boolean  "default",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prosperity_metrics", force: true do |t|
    t.integer  "view_id",    null: false
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prosperity_metrics", ["view_id"], name: "index_prosperity_metrics_on_view_id", using: :btree

  create_table "prosperity_views", force: true do |t|
    t.string   "period",     null: false
    t.string   "option",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
