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

ActiveRecord::Schema.define(version: 20160229213007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_stat_statements"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "username",               default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  add_index "admin_users", ["username"], name: "index_admin_users_on_username", unique: true, using: :btree

  create_table "avatars", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "base_products", force: true do |t|
    t.string   "name",        limit: nil
    t.text     "description"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "categories", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "slug"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_posts", id: false, force: true do |t|
    t.integer "category_id"
    t.integer "post_id"
  end

  create_table "channels", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "slug"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.boolean  "hidden"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
  end

  create_table "channels_shows", id: false, force: true do |t|
    t.integer "show_id"
    t.integer "channel_id"
  end

  create_table "chicago_votes", force: true do |t|
    t.integer  "voteable_id",                  null: false
    t.string   "voteable_type",                null: false
    t.boolean  "vote_flag",     default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "email"
    t.string   "subject"
    t.text     "body"
    t.string   "ip"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations", force: true do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "creators", force: true do |t|
    t.string   "username"
    t.string   "displayname"
    t.string   "email"
    t.string   "encrypted_password"
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "background_file_name"
    t.string   "background_content_type"
    t.integer  "background_file_size"
    t.datetime "background_updated_at"
    t.string   "slug"
    t.boolean  "hidden"
    t.string   "google"
    t.string   "website"
    t.string   "facebook"
    t.string   "youtube"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "creators", ["reset_password_token"], name: "index_creators_on_reset_password_token", unique: true, using: :btree

  create_table "embeds", force: true do |t|
    t.string   "provider"
    t.text     "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "needs_permission", default: false
  end

  create_table "episodes", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "approved"
    t.string   "slug"
    t.integer  "show_id"
    t.string   "embed_id"
    t.string   "video"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "cached_votes_total", default: 0
    t.integer  "cached_votes_score", default: 0
    t.integer  "cached_votes_up",    default: 0
    t.integer  "cached_votes_down",  default: 0
    t.integer  "episode"
    t.string   "duration"
    t.string   "age_range"
    t.integer  "chicago"
  end

  add_index "episodes", ["cached_votes_down"], name: "index_episodes_on_cached_votes_down", using: :btree
  add_index "episodes", ["cached_votes_score"], name: "index_episodes_on_cached_votes_score", using: :btree
  add_index "episodes", ["cached_votes_total"], name: "index_episodes_on_cached_votes_total", using: :btree
  add_index "episodes", ["cached_votes_up"], name: "index_episodes_on_cached_votes_up", using: :btree
  add_index "episodes", ["slug"], name: "index_episodes_on_slug", unique: true, using: :btree

  create_table "episodes_tournaments", id: false, force: true do |t|
    t.integer "episode_id",    null: false
    t.integer "tournament_id", null: false
  end

  create_table "features", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.boolean  "active"
    t.integer  "owner_id"
    t.integer  "seconds"
    t.string   "owner_type"
  end

  create_table "follows", force: true do |t|
    t.integer  "followable_id",                   null: false
    t.string   "followable_type",                 null: false
    t.integer  "follower_id",                     null: false
    t.string   "follower_type",                   null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "friend_episodes", force: true do |t|
    t.integer  "friend_id"
    t.integer  "episode_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "friend_episodes", ["episode_id"], name: "index_friend_episodes_on_episode_id", using: :btree
  add_index "friend_episodes", ["friend_id"], name: "index_friend_episodes_on_friend_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "friends", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "description"
    t.string   "sponsor"
    t.string   "primary_color"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "background_file_name"
    t.string   "background_content_type"
    t.integer  "background_file_size"
    t.datetime "background_updated_at"
    t.boolean  "features_autoplay"
    t.string   "features_exit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "approved"
    t.boolean  "hide_sponsor_banner"
    t.string   "sidebar_image_file_name"
    t.string   "sidebar_image_content_type"
    t.integer  "sidebar_image_file_size"
    t.datetime "sidebar_image_updated_at"
    t.string   "sidebar_image_link"
    t.boolean  "hide_sponsor_listing"
    t.boolean  "background_full",            default: false, null: false
    t.text     "dfp_header_code"
    t.text     "dfp_banner_ad"
    t.text     "dfp_mid_side_ad"
    t.boolean  "hide_sponsor_globally",      default: false
  end

  create_table "links", force: true do |t|
    t.string   "url"
    t.text     "data"
    t.integer  "linkedmedia_id"
    t.string   "linkedmedia_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link_type"
    t.string   "title"
  end

  create_table "matches", force: true do |t|
    t.integer  "first_seat"
    t.integer  "second_seat"
    t.integer  "player_one_id"
    t.integer  "player_two_id"
    t.datetime "start"
    t.datetime "finish"
    t.integer  "tournament_id"
    t.string   "status",                 default: "scheduled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "billboard_file_name"
    t.string   "billboard_content_type"
    t.integer  "billboard_file_size"
    t.datetime "billboard_updated_at"
  end

  create_table "menus", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "position"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "notification_code"
    t.string   "attachment"
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "notifications", ["conversation_id"], name: "index_notifications_on_conversation_id", using: :btree

  create_table "pages", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pg_search_documents", force: true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "featured_image_file_name"
    t.string   "featured_image_content_type"
    t.integer  "featured_image_file_size"
    t.datetime "featured_image_updated_at"
  end

  create_table "products", force: true do |t|
    t.integer  "base_product_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "products", ["base_product_id"], name: "index_products_on_base_product_id", using: :btree

  create_table "receipts", force: true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "receipts", ["notification_id"], name: "index_receipts_on_notification_id", using: :btree

  create_table "rich_rich_files", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rich_file_file_name"
    t.string   "rich_file_content_type"
    t.integer  "rich_file_file_size"
    t.datetime "rich_file_updated_at"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.text     "uri_cache"
    t.string   "simplified_type",        default: "file"
  end

  create_table "security_questions", force: true do |t|
    t.string "locale", null: false
    t.string "name",   null: false
  end

  create_table "sensor_events", force: true do |t|
    t.datetime "timestamp"
    t.float    "force"
    t.float    "xaccel"
    t.float    "yaccel"
    t.float    "zaccel"
    t.float    "battery"
    t.float    "position"
    t.float    "tension"
    t.integer  "sensor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sensor_events", ["sensor_id"], name: "index_sensor_events_on_sensor_id", using: :btree

  create_table "sensors", force: true do |t|
    t.string   "serial",     limit: nil
    t.string   "model",      limit: nil
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "shows", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "approved"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "single"
    t.string   "slug"
    t.string   "subtitle"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "background_file_name"
    t.string   "background_content_type"
    t.integer  "background_file_size"
    t.datetime "background_updated_at"
    t.boolean  "promote"
    t.boolean  "skiplist"
    t.integer  "position"
    t.string   "age_range"
    t.string   "sort_title"
  end

  add_index "shows", ["slug"], name: "index_shows_on_slug", unique: true, using: :btree

  create_table "sidebars", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_answers", force: true do |t|
    t.integer  "attempt_id"
    t.integer  "question_id"
    t.integer  "option_id"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_attempts", force: true do |t|
    t.integer "participant_id"
    t.string  "participant_type"
    t.integer "survey_id"
    t.boolean "winner"
    t.integer "score"
  end

  create_table "survey_options", force: true do |t|
    t.integer  "question_id"
    t.integer  "weight",      default: 0
    t.string   "text"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_questions", force: true do |t|
    t.integer  "survey_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_surveys", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "attempts_number", default: 0
    t.boolean  "finished",        default: false
    t.boolean  "active",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "tournament_votes", force: true do |t|
    t.integer  "match_id"
    t.integer  "episode_id"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tournament_votes", ["episode_id"], name: "index_tournament_votes_on_episode_id", using: :btree
  add_index "tournament_votes", ["match_id"], name: "index_tournament_votes_on_match_id", using: :btree

  create_table "tournaments", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "slug"
    t.string   "subtitle"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "background_file_name"
    t.string   "background_content_type"
    t.integer  "background_file_size"
    t.datetime "background_updated_at"
    t.boolean  "promote"
    t.boolean  "skiplist"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_date"
    t.text     "dfp_header_code"
    t.text     "dfp_banner_ad"
  end

  create_table "username_words", force: true do |t|
    t.string   "kind"
    t.string   "word"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                       default: ""
    t.string   "username",                    default: "",    null: false
    t.string   "encrypted_password"
    t.string   "gender"
    t.date     "birthday"
    t.integer  "avatar_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",               default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "slug"
    t.string   "kpass_id"
    t.string   "kpass_access_key"
    t.boolean  "access_to_moderated_chats",   default: false
    t.boolean  "youtube_and_3rdparty_videos", default: false
    t.boolean  "publish_public_profile",      default: false
    t.boolean  "rejected",                    default: false
    t.boolean  "approved",                    default: false
    t.string   "parent_email"
    t.boolean  "username_avatar_age_gender",  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

  add_foreign_key "matches", "episodes", name: "matches_player_one_id_fk", column: "player_one_id"
  add_foreign_key "matches", "episodes", name: "matches_player_two_id_fk", column: "player_two_id"

  add_foreign_key "notifications", "conversations", name: "notifications_on_conversation_id"

  add_foreign_key "products", "base_products", name: "fk_rails_b033e49a6a"

  add_foreign_key "receipts", "notifications", name: "receipts_on_notification_id"

  add_foreign_key "sensor_events", "sensors", name: "fk_rails_d3ce334b08"

end
