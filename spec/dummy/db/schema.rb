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

ActiveRecord::Schema.define(version: 20140217005117) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "prosperity_dashboard_graphs", force: true do |t|
    t.integer  "graph_id",     null: false
    t.integer  "dashboard_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prosperity_dashboard_graphs", ["dashboard_id"], name: "index_prosperity_dashboard_graphs_on_dashboard_id", using: :btree
  add_index "prosperity_dashboard_graphs", ["graph_id", "dashboard_id"], name: "index_prosperity_dashboard_graphs_on_graph_id_and_dashboard_id", unique: true, using: :btree

  create_table "prosperity_dashboards", force: true do |t|
    t.string   "title",      null: false
    t.boolean  "default",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prosperity_graph_lines", force: true do |t|
    t.integer  "graph_id",   null: false
    t.string   "option",     null: false
    t.string   "metric",     null: false
    t.string   "extractor",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prosperity_graph_lines", ["graph_id"], name: "index_prosperity_graph_lines_on_graph_id", using: :btree

  create_table "prosperity_graphs", force: true do |t|
    t.string   "title",      null: false
    t.string   "period",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "value"
  end

end
