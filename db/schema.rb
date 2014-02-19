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

ActiveRecord::Schema.define(version: 20140217210036) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string    "namespace"
    t.text      "body"
    t.string    "resource_id",                 null: false
    t.string    "resource_type",               null: false
    t.integer   "author_id"
    t.string    "author_type"
    t.timestamp "created_at",    precision: 6
    t.timestamp "updated_at",    precision: 6
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string    "username",                             default: "", null: false
    t.string    "email",                                default: "", null: false
    t.string    "encrypted_password",                   default: "", null: false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at", precision: 6
    t.timestamp "remember_created_at",    precision: 6
    t.integer   "sign_in_count",                        default: 0
    t.timestamp "current_sign_in_at",     precision: 6
    t.timestamp "last_sign_in_at",        precision: 6
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at",             precision: 6
    t.timestamp "updated_at",             precision: 6
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  add_index "admin_users", ["username"], name: "index_admin_users_on_username", unique: true, using: :btree

  create_table "avatars", force: true do |t|
    t.string    "name"
    t.timestamp "created_at",         precision: 6
    t.timestamp "updated_at",         precision: 6
    t.string    "image_file_name"
    t.string    "image_content_type"
    t.integer   "image_file_size"
    t.timestamp "image_updated_at",   precision: 6
  end

  create_table "categories", force: true do |t|
    t.string    "title"
    t.text      "description"
    t.string    "slug"
    t.integer   "parent_id"
    t.timestamp "created_at",  precision: 6
    t.timestamp "updated_at",  precision: 6
  end

  create_table "categories_posts", id: false, force: true do |t|
    t.integer "category_id"
    t.integer "post_id"
  end

  create_table "channels", force: true do |t|
    t.string    "title"
    t.text      "description"
    t.string    "slug"
    t.integer   "parent_id"
    t.timestamp "created_at",        precision: 6
    t.timestamp "updated_at",        precision: 6
    t.integer   "position"
    t.boolean   "hidden"
    t.string    "icon_file_name"
    t.string    "icon_content_type"
    t.integer   "icon_file_size"
    t.timestamp "icon_updated_at",   precision: 6
  end

  create_table "channels_shows", id: false, force: true do |t|
    t.integer "show_id"
    t.integer "channel_id"
  end

  create_table "conversations", force: true do |t|
    t.string    "subject",                  default: ""
    t.timestamp "created_at", precision: 6,              null: false
    t.timestamp "updated_at", precision: 6,              null: false
  end

  create_table "creators", force: true do |t|
    t.string    "username"
    t.string    "displayname"
    t.string    "email"
    t.string    "encrypted_password"
    t.text      "bio"
    t.timestamp "created_at",              precision: 6
    t.timestamp "updated_at",              precision: 6
    t.string    "image_file_name"
    t.string    "image_content_type"
    t.integer   "image_file_size"
    t.timestamp "image_updated_at",        precision: 6
    t.string    "background_file_name"
    t.string    "background_content_type"
    t.integer   "background_file_size"
    t.timestamp "background_updated_at",   precision: 6
    t.string    "slug"
    t.boolean   "hidden"
  end

  create_table "embeds", force: true do |t|
    t.string    "provider"
    t.text      "code"
    t.timestamp "created_at", precision: 6
    t.timestamp "updated_at", precision: 6
  end

  create_table "episodes", force: true do |t|
    t.string    "title"
    t.text      "description"
    t.boolean   "approved"
    t.string    "slug"
    t.integer   "show_id"
    t.string    "embed_id"
    t.string    "video"
    t.timestamp "created_at",         precision: 6
    t.timestamp "updated_at",         precision: 6
    t.string    "image_file_name"
    t.string    "image_content_type"
    t.integer   "image_file_size"
    t.timestamp "image_updated_at",   precision: 6
    t.integer   "cached_votes_total",               default: 0
    t.integer   "cached_votes_score",               default: 0
    t.integer   "cached_votes_up",                  default: 0
    t.integer   "cached_votes_down",                default: 0
    t.integer   "episode"
    t.string    "duration"
    t.string    "age_range"
    t.integer   "chicago"
  end

  add_index "episodes", ["cached_votes_down"], name: "index_episodes_on_cached_votes_down", using: :btree
  add_index "episodes", ["cached_votes_score"], name: "index_episodes_on_cached_votes_score", using: :btree
  add_index "episodes", ["cached_votes_total"], name: "index_episodes_on_cached_votes_total", using: :btree
  add_index "episodes", ["cached_votes_up"], name: "index_episodes_on_cached_votes_up", using: :btree
  add_index "episodes", ["slug"], name: "index_episodes_on_slug", unique: true, using: :btree

  create_table "features", force: true do |t|
    t.string    "title"
    t.text      "content"
    t.timestamp "created_at", precision: 6
    t.timestamp "updated_at", precision: 6
    t.integer   "position"
    t.boolean   "active"
    t.integer   "owner_id"
    t.integer   "seconds"
    t.string    "owner_type"
  end

  create_table "follows", force: true do |t|
    t.integer   "followable_id",                                 null: false
    t.string    "followable_type",                               null: false
    t.integer   "follower_id",                                   null: false
    t.string    "follower_type",                                 null: false
    t.boolean   "blocked",                       default: false, null: false
    t.timestamp "created_at",      precision: 6
    t.timestamp "updated_at",      precision: 6
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "friend_episodes", force: true do |t|
    t.integer   "friend_id"
    t.integer   "episode_id"
    t.timestamp "created_at", precision: 6
    t.timestamp "updated_at", precision: 6
  end

  add_index "friend_episodes", ["episode_id"], name: "index_friend_episodes_on_episode_id", using: :btree
  add_index "friend_episodes", ["friend_id"], name: "index_friend_episodes_on_friend_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string    "slug",                                    null: false
    t.integer   "sluggable_id",                            null: false
    t.string    "sluggable_type", limit: 50
    t.string    "scope"
    t.timestamp "created_at",                precision: 6
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "friends", force: true do |t|
    t.string    "title"
    t.string    "slug"
    t.text      "description"
    t.string    "sponsor"
    t.string    "primary_color"
    t.string    "image_file_name"
    t.string    "image_content_type"
    t.integer   "image_file_size"
    t.timestamp "image_updated_at",        precision: 6
    t.string    "background_file_name"
    t.string    "background_content_type"
    t.integer   "background_file_size"
    t.timestamp "background_updated_at",   precision: 6
    t.boolean   "features_autoplay"
    t.string    "features_exit"
    t.timestamp "created_at",              precision: 6
    t.timestamp "updated_at",              precision: 6
    t.boolean   "approved"
  end

  create_table "notifications", force: true do |t|
    t.string    "type"
    t.text      "body"
    t.string    "subject",                            default: ""
    t.integer   "sender_id"
    t.string    "sender_type"
    t.integer   "conversation_id"
    t.boolean   "draft",                              default: false
    t.timestamp "updated_at",           precision: 6,                 null: false
    t.timestamp "created_at",           precision: 6,                 null: false
    t.integer   "notified_object_id"
    t.string    "notified_object_type"
    t.string    "notification_code"
    t.string    "attachment"
    t.boolean   "global",                             default: false
    t.timestamp "expires",              precision: 6
  end

  add_index "notifications", ["conversation_id"], name: "index_notifications_on_conversation_id", using: :btree

  create_table "pg_search_documents", force: true do |t|
    t.text      "content"
    t.integer   "searchable_id"
    t.string    "searchable_type"
    t.timestamp "created_at",      precision: 6
    t.timestamp "updated_at",      precision: 6
  end

  create_table "posts", force: true do |t|
    t.string    "title"
    t.text      "body"
    t.string    "slug"
    t.timestamp "created_at",                  precision: 6
    t.timestamp "updated_at",                  precision: 6
    t.string    "featured_image_file_name"
    t.string    "featured_image_content_type"
    t.integer   "featured_image_file_size"
    t.timestamp "featured_image_updated_at",   precision: 6
  end

  create_table "receipts", force: true do |t|
    t.integer   "receiver_id"
    t.string    "receiver_type"
    t.integer   "notification_id",                                          null: false
    t.boolean   "is_read",                                  default: false
    t.boolean   "trashed",                                  default: false
    t.boolean   "deleted",                                  default: false
    t.string    "mailbox_type",    limit: 25
    t.timestamp "created_at",                 precision: 6,                 null: false
    t.timestamp "updated_at",                 precision: 6,                 null: false
  end

  add_index "receipts", ["notification_id"], name: "index_receipts_on_notification_id", using: :btree

  create_table "rich_rich_files", force: true do |t|
    t.timestamp "created_at",             precision: 6
    t.timestamp "updated_at",             precision: 6
    t.string    "rich_file_file_name"
    t.string    "rich_file_content_type"
    t.integer   "rich_file_file_size"
    t.timestamp "rich_file_updated_at",   precision: 6
    t.string    "owner_type"
    t.integer   "owner_id"
    t.text      "uri_cache"
    t.string    "simplified_type",                      default: "file"
  end

  create_table "security_questions", force: true do |t|
    t.string "locale", null: false
    t.string "name",   null: false
  end

  create_table "shows", force: true do |t|
    t.string    "title"
    t.text      "description"
    t.boolean   "approved"
    t.integer   "creator_id"
    t.timestamp "created_at",              precision: 6
    t.timestamp "updated_at",              precision: 6
    t.boolean   "single"
    t.string    "slug"
    t.string    "subtitle"
    t.string    "image_file_name"
    t.string    "image_content_type"
    t.integer   "image_file_size"
    t.timestamp "image_updated_at",        precision: 6
    t.string    "background_file_name"
    t.string    "background_content_type"
    t.integer   "background_file_size"
    t.timestamp "background_updated_at",   precision: 6
    t.boolean   "promote"
    t.boolean   "skiplist"
    t.integer   "position"
    t.string    "age_range"
  end

  add_index "shows", ["slug"], name: "index_shows_on_slug", unique: true, using: :btree

  create_table "survey_answers", force: true do |t|
    t.integer   "attempt_id"
    t.integer   "question_id"
    t.integer   "option_id"
    t.boolean   "correct"
    t.timestamp "created_at",  precision: 6
    t.timestamp "updated_at",  precision: 6
  end

  create_table "survey_attempts", force: true do |t|
    t.integer "participant_id"
    t.string  "participant_type"
    t.integer "survey_id"
    t.boolean "winner"
    t.integer "score"
  end

  create_table "survey_options", force: true do |t|
    t.integer   "question_id"
    t.integer   "weight",                    default: 0
    t.string    "text"
    t.boolean   "correct"
    t.timestamp "created_at",  precision: 6
    t.timestamp "updated_at",  precision: 6
  end

  create_table "survey_questions", force: true do |t|
    t.integer   "survey_id"
    t.string    "text"
    t.timestamp "created_at", precision: 6
    t.timestamp "updated_at", precision: 6
  end

  create_table "survey_surveys", force: true do |t|
    t.string    "name"
    t.text      "description"
    t.integer   "attempts_number",               default: 0
    t.boolean   "finished",                      default: false
    t.boolean   "active",                        default: false
    t.timestamp "created_at",      precision: 6
    t.timestamp "updated_at",      precision: 6
  end

  create_table "taggings", force: true do |t|
    t.integer   "tag_id"
    t.integer   "taggable_id"
    t.string    "taggable_type"
    t.integer   "tagger_id"
    t.string    "tagger_type"
    t.string    "context",       limit: 128
    t.timestamp "created_at",                precision: 6
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "username_words", force: true do |t|
    t.string    "kind"
    t.string    "word"
    t.timestamp "created_at", precision: 6
    t.timestamp "updated_at", precision: 6
  end

  create_table "users", force: true do |t|
    t.string    "firstname"
    t.string    "lastname"
    t.string    "email",                                  default: ""
    t.string    "username",                               default: "", null: false
    t.string    "encrypted_password"
    t.string    "gender"
    t.date      "birthday"
    t.integer   "security_question_id"
    t.string    "security_question_answer"
    t.integer   "avatar_id"
    t.timestamp "created_at",               precision: 6
    t.timestamp "updated_at",               precision: 6
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at",   precision: 6
    t.timestamp "remember_created_at",      precision: 6
    t.integer   "sign_in_count",                          default: 0
    t.timestamp "current_sign_in_at",       precision: 6
    t.timestamp "last_sign_in_at",          precision: 6
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.integer   "parent_id",                              default: 0,  null: false
    t.string    "slug"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["parent_id"], name: "index_users_on_parent_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.integer   "votable_id"
    t.string    "votable_type"
    t.integer   "voter_id"
    t.string    "voter_type"
    t.boolean   "vote_flag"
    t.string    "vote_scope"
    t.timestamp "created_at",   precision: 6
    t.timestamp "updated_at",   precision: 6
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

  add_foreign_key "notifications", "conversations", name: "notifications_on_conversation_id"

  add_foreign_key "receipts", "notifications", name: "receipts_on_notification_id"

end
