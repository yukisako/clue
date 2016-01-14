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

ActiveRecord::Schema.define(version: 20160114215714) do

  create_table "absence_triggers", force: :cascade do |t|
    t.boolean  "classroom"
    t.boolean  "harm"
    t.boolean  "antipathy"
    t.boolean  "teacher"
    t.boolean  "friendship"
    t.boolean  "study"
    t.boolean  "change_school"
    t.boolean  "neglect"
    t.boolean  "dv"
    t.boolean  "poverty"
    t.boolean  "parents"
    t.boolean  "no_reason"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "user_id",       limit: 4
  end

  create_table "accounts", force: :cascade do |t|
    t.string   "bank_id",    limit: 255
    t.integer  "store_id",   limit: 4
    t.string   "bank_name",  limit: 255
    t.string   "store_name", limit: 255
    t.string   "account_id", limit: 255
    t.string   "user_name",  limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "bank_data", force: :cascade do |t|
    t.string   "bank_id",         limit: 255
    t.integer  "store_id",        limit: 4
    t.string   "bank_name",       limit: 255
    t.string   "bank_name_kana",  limit: 255
    t.string   "store_name",      limit: 255
    t.string   "store_name_kana", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "banks", force: :cascade do |t|
    t.integer  "bank_id",    limit: 4
    t.string   "store_id",   limit: 255
    t.string   "name",       limit: 255
    t.string   "name_kana",  limit: 255
    t.integer  "bank_flag",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "diary_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.text     "comment",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "diaries", force: :cascade do |t|
    t.string   "category",   limit: 255
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.integer  "permit",     limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.text     "content",            limit: 65535
    t.datetime "held_at"
    t.string   "price",              limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "sender_id",   limit: 4
    t.integer  "receiver_id", limit: 4
    t.string   "title",       limit: 255
    t.text     "message",     limit: 65535
    t.integer  "sent",        limit: 4
    t.integer  "opened",      limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "offer_id",    limit: 4
  end

  create_table "new_infos", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.text     "content",            limit: 65535
    t.datetime "held_at"
    t.string   "price",              limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  create_table "offers", force: :cascade do |t|
    t.integer  "ticket_id",  limit: 4
    t.integer  "user_id",    limit: 4
    t.integer  "price",      limit: 4
    t.decimal  "length",                   precision: 10
    t.datetime "meet_at"
    t.string   "area",       limit: 255
    t.string   "place",      limit: 255
    t.text     "message",    limit: 65535
    t.integer  "status",     limit: 4
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "updated",    limit: 4
    t.integer  "rate",       limit: 4
  end

  create_table "participants", force: :cascade do |t|
    t.integer  "event_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.string   "status",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "amount",     limit: 4
    t.string   "bank_name",  limit: 255
    t.string   "store_name", limit: 255
    t.string   "account_id", limit: 255
    t.string   "user_name",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "reported_accounts", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "reporter_id", limit: 4
    t.text     "reason",      limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "ticket_id",  limit: 4
    t.integer  "user_id",    limit: 4
    t.text     "review",     limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "reputation", limit: 4
  end

  create_table "social_profiles", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.string   "provider",      limit: 255
    t.string   "uid",           limit: 255
    t.string   "access_token",  limit: 255
    t.string   "access_secret", limit: 255
    t.string   "name",          limit: 255
    t.string   "nickname",      limit: 255
    t.string   "email",         limit: 255
    t.string   "url",           limit: 255
    t.string   "image_url",     limit: 255
    t.string   "description",   limit: 255
    t.text     "other",         limit: 65535
    t.text     "credentials",   limit: 65535
    t.text     "raw_info",      limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "title",      limit: 255
    t.integer  "price",      limit: 4
    t.integer  "length",     limit: 4
    t.integer  "rate",       limit: 4
    t.string   "area",       limit: 255
    t.string   "place",      limit: 255
    t.text     "message",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "name",                   limit: 255
    t.string   "name_kana",              limit: 255
    t.string   "family_name",            limit: 255
    t.string   "first_name",             limit: 255
    t.string   "family_name_kana",       limit: 255
    t.string   "first_name_kana",        limit: 255
    t.integer  "user_type",              limit: 4
    t.string   "area",                   limit: 255
    t.string   "sex",                    limit: 255
    t.date     "birth"
    t.text     "profile",                limit: 65535
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "address",                limit: 255
    t.string   "tel",                    limit: 255
    t.string   "job",                    limit: 255
    t.string   "line_id",                limit: 255
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
    t.integer  "search_permit",          limit: 4
    t.string   "username",               limit: 255
    t.string   "post_number",            limit: 255
    t.integer  "permit_info_mail",       limit: 4
    t.string   "absent_span",            limit: 255
    t.text     "school",                 limit: 65535
    t.text     "grade",                  limit: 65535
    t.integer  "block",                  limit: 4
    t.integer  "reported",               limit: 4
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
