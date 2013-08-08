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

ActiveRecord::Schema.define(version: 20130808063358) do

  create_table "creators", force: true do |t|
    t.string   "username"
    t.string   "displayname"
    t.string   "email"
    t.string   "encrypted_password"
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "episodes", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "approved"
    t.integer  "creator_id"
    t.integer  "show_id"
    t.integer  "video_type"
    t.string   "video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shows", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "approved"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email",                    default: ""
    t.string   "username",                 default: "", null: false
    t.string   "encrypted_password"
    t.string   "gender"
    t.date     "birthday"
    t.integer  "security_question_id"
    t.string   "security_question_answer"
    t.integer  "avatar_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "parent_id",                default: 0,  null: false
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["parent_id"], name: "index_users_on_parent_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
