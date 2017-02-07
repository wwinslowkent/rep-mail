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

ActiveRecord::Schema.define(version: 20170207142826) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.string   "title",       null: false
    t.string   "description", null: false
    t.string   "location",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "bmessages", force: :cascade do |t|
    t.integer "bill_id"
    t.integer "message_id"
    t.index ["bill_id"], name: "index_bmessages_on_bill_id", using: :btree
    t.index ["message_id"], name: "index_bmessages_on_message_id", using: :btree
  end

  create_table "imessages", force: :cascade do |t|
    t.integer "issue_id"
    t.integer "message_id"
    t.index ["issue_id"], name: "index_imessages_on_issue_id", using: :btree
    t.index ["message_id"], name: "index_imessages_on_message_id", using: :btree
  end

  create_table "issues", force: :cascade do |t|
    t.string   "title",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string   "title",      null: false
    t.text     "body",       null: false
    t.boolean  "procon"
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "vote"
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "representatives", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "state",      null: false
    t.string   "party",      null: false
    t.string   "address",    null: false
    t.string   "phone",      null: false
    t.string   "website",    null: false
    t.string   "image",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rzips", force: :cascade do |t|
    t.integer "representative_id", null: false
    t.integer "zipcode_id",        null: false
    t.index ["representative_id"], name: "index_rzips_on_representative_id", using: :btree
    t.index ["zipcode_id"], name: "index_rzips_on_zipcode_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.boolean  "admin",                  default: false, null: false
    t.string   "username",                               null: false
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
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "zip"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.string  "vote",       null: false
    t.integer "user_id"
    t.integer "message_id"
    t.index ["message_id"], name: "index_votes_on_message_id", using: :btree
    t.index ["user_id"], name: "index_votes_on_user_id", using: :btree
  end

  create_table "zipcodes", force: :cascade do |t|
    t.string "zip", null: false
  end

end
