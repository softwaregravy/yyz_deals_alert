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

ActiveRecord::Schema.define(version: 20160520010441) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aws_tickwork_db_data_stores", force: :cascade do |t|
    t.string   "key",        null: false
    t.integer  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "aws_tickwork_db_data_stores", ["key"], name: "index_aws_tickwork_db_data_stores_on_key", unique: true, using: :btree

  create_table "feeds", force: :cascade do |t|
    t.string   "name"
    t.string   "url",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
  end

  add_index "feeds", ["name"], name: "index_feeds_on_name", unique: true, using: :btree
  add_index "feeds", ["url"], name: "index_feeds_on_url", unique: true, using: :btree

  create_table "notifications", force: :cascade do |t|
    t.string   "subject"
    t.string   "body"
    t.string   "short_message"
    t.integer  "notification_source_id"
    t.string   "notification_source_type"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "notifications", ["notification_source_type", "notification_source_id"], name: "index_notifications_notifications_source", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title",      null: false
    t.string   "url",        null: false
    t.integer  "feed_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["feed_id", "title", "url"], name: "index_posts_on_feed_id_and_title_and_url", unique: true, using: :btree
  add_index "posts", ["feed_id"], name: "index_posts_on_feed_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "roles", ["name"], name: "index_roles_on_name", unique: true, using: :btree

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "role_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "roles_users", ["role_id", "user_id"], name: "index_roles_users_on_role_id_and_user_id", using: :btree
  add_index "roles_users", ["user_id", "role_id"], name: "index_roles_users_on_user_id_and_role_id", using: :btree

  create_table "sms_message_attempts", force: :cascade do |t|
    t.datetime "attempted"
    t.boolean  "successful",     default: false, null: false
    t.string   "to_number",                      null: false
    t.string   "from_number",                    null: false
    t.string   "body",                           null: false
    t.integer  "sms_message_id",                 null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "sms_message_attempts", ["sms_message_id"], name: "index_sms_message_attempts_on_sms_message_id", using: :btree

  create_table "sms_messages", force: :cascade do |t|
    t.datetime "send_initiated"
    t.datetime "send_completed"
    t.boolean  "retry_enabled",   default: true, null: false
    t.integer  "max_attempts",    default: 1,    null: false
    t.integer  "user_id",                        null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "notification_id"
  end

  add_index "sms_messages", ["user_id"], name: "index_sms_messages_on_user_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id",                 null: false
    t.integer  "subscribable_id",         null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "subscribable_type",       null: false
    t.string   "notification_preference", null: false
  end

  add_index "subscriptions", ["subscribable_id"], name: "index_subscriptions_on_subscribable_id", using: :btree
  add_index "subscriptions", ["user_id", "subscribable_id", "subscribable_type"], name: "unique_user_subscriptions", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "phone_number"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "notifications_enabled",  default: false, null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "web_page_visits", force: :cascade do |t|
    t.integer  "web_page_id"
    t.string   "checksum"
    t.integer  "size"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "web_page_visits", ["web_page_id"], name: "index_web_page_visits_on_web_page_id", using: :btree

  create_table "web_pages", force: :cascade do |t|
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "web_pages", ["url"], name: "index_web_pages_on_url", unique: true, using: :btree

  add_foreign_key "posts", "feeds"
  add_foreign_key "sms_message_attempts", "sms_messages"
  add_foreign_key "sms_messages", "users"
  add_foreign_key "web_page_visits", "web_pages"
end
