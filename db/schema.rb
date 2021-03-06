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

ActiveRecord::Schema.define(version: 20160209185815) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "activity_category_id"
    t.text     "description"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "gathering_id"
    t.integer  "user_id"
  end

  add_index "activities", ["activity_category_id"], name: "index_activities_on_activity_category_id", using: :btree
  add_index "activities", ["gathering_id"], name: "index_activities_on_gathering_id", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "activity_categories", force: :cascade do |t|
    t.string   "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "gathering_id"
    t.text     "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "comments", ["gathering_id"], name: "index_comments_on_gathering_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "finalized_plans", force: :cascade do |t|
    t.integer  "gathering_id"
    t.integer  "moment_id"
    t.integer  "place_id"
    t.integer  "activity_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "finalized_plans", ["activity_id"], name: "index_finalized_plans_on_activity_id", using: :btree
  add_index "finalized_plans", ["gathering_id"], name: "index_finalized_plans_on_gathering_id", using: :btree
  add_index "finalized_plans", ["moment_id"], name: "index_finalized_plans_on_moment_id", using: :btree
  add_index "finalized_plans", ["place_id"], name: "index_finalized_plans_on_place_id", using: :btree

  create_table "gatherings", force: :cascade do |t|
    t.string   "title"
    t.integer  "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "aasm_state"
  end

  add_index "gatherings", ["owner_id"], name: "index_gatherings_on_owner_id", using: :btree

  create_table "interests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "gathering_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "notified_at"
  end

  add_index "interests", ["gathering_id"], name: "index_interests_on_gathering_id", using: :btree
  add_index "interests", ["user_id"], name: "index_interests_on_user_id", using: :btree

  create_table "moments", force: :cascade do |t|
    t.datetime "time"
    t.integer  "gathering_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "moments", ["gathering_id"], name: "index_moments_on_gathering_id", using: :btree
  add_index "moments", ["user_id"], name: "index_moments_on_user_id", using: :btree

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "gathering_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "places", ["gathering_id"], name: "index_places_on_gathering_id", using: :btree
  add_index "places", ["user_id"], name: "index_places_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "value"
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree
  add_index "votes", ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id", using: :btree

  add_foreign_key "activities", "activity_categories"
  add_foreign_key "activities", "gatherings"
  add_foreign_key "activities", "users"
  add_foreign_key "comments", "gatherings"
  add_foreign_key "comments", "users"
  add_foreign_key "finalized_plans", "activities"
  add_foreign_key "finalized_plans", "gatherings"
  add_foreign_key "finalized_plans", "moments"
  add_foreign_key "finalized_plans", "places"
  add_foreign_key "gatherings", "users", column: "owner_id"
  add_foreign_key "interests", "gatherings"
  add_foreign_key "interests", "users"
  add_foreign_key "moments", "gatherings"
  add_foreign_key "moments", "users"
  add_foreign_key "places", "gatherings"
  add_foreign_key "places", "users"
  add_foreign_key "votes", "users"
end
