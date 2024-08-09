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

ActiveRecord::Schema.define(version: 20160127162859) do

  create_table "clients", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "zip"
    t.string   "state"
    t.string   "phone"
    t.integer  "plan_id"
    t.datetime "startdate"
    t.datetime "updated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "email"
  end

  add_index "clients", ["client_id"], name: "index_clients_on_client_id", unique: true

  create_table "contractors", force: :cascade do |t|
    t.integer  "cont_id"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "zip"
    t.string   "state"
    t.string   "phone"
    t.string   "email"
    t.datetime "startdate"
    t.datetime "updated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "contractors", ["cont_id"], name: "index_contractors_on_cont_id", unique: true

end
