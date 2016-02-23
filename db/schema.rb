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

ActiveRecord::Schema.define(version: 20160223154746) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "leagues", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "entries"
  end

  create_table "schools", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "abbreviation"
    t.string   "head_coach"
    t.string   "address"
    t.integer  "auth_users",   default: 3, null: false
    t.integer  "league_id"
  end

  add_index "schools", ["league_id"], name: "index_schools_on_league_id", using: :btree

  create_table "tournaments", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name",                   default: "", null: false
    t.boolean  "league_rep"
    t.string   "cell"
    t.boolean  "admin"
    t.integer  "league_id"
    t.integer  "school_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["league_id"], name: "index_users_on_league_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["school_id"], name: "index_users_on_school_id", using: :btree

  create_table "wrestlers", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "school"
    t.string   "league"
    t.integer  "weight"
    t.integer  "grade"
    t.integer  "wins"
    t.integer  "losses"
    t.integer  "seed"
    t.string   "league_place"
    t.integer  "section_place"
    t.integer  "state_place"
    t.string   "t1_name"
    t.integer  "t1_place"
    t.string   "t2_name"
    t.integer  "t2_place"
    t.string   "t3_name"
    t.integer  "t3_place"
    t.string   "t4_name"
    t.integer  "t4_place"
    t.string   "t5_name"
    t.integer  "t5_place"
    t.string   "h2h_1"
    t.string   "h2h_r1"
    t.string   "h2h_2"
    t.string   "h2h_r2"
    t.string   "h2h_3"
    t.string   "h2h_r3"
    t.string   "h2h_4"
    t.string   "h2h_r4"
    t.string   "h2h_5"
    t.string   "h2h_r5"
    t.text     "comments"
    t.integer  "school_id"
    t.boolean  "alternate"
    t.integer  "league_id"
  end

  add_index "wrestlers", ["league_id"], name: "index_wrestlers_on_league_id", using: :btree
  add_index "wrestlers", ["school_id"], name: "index_wrestlers_on_school_id", using: :btree

end
