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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130428054830) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "authentications", :force => true do |t|
    t.string   "provider",   :limit => 16
    t.string   "uid",        :limit => 64
    t.string   "token"
    t.string   "secret"
    t.integer  "user_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "authentications", ["provider"], :name => "index_authentications_on_provider"
  add_index "authentications", ["uid"], :name => "index_authentications_on_uid"

  create_table "events", :force => true do |t|
    t.string   "title"
    t.string   "city"
    t.string   "map"
    t.date     "starts_at"
    t.string   "summary"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "identities", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "confirmation_code"
    t.boolean  "confirmed",         :default => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "identities", ["confirmation_code"], :name => "index_identities_on_confirmation_code"
  add_index "identities", ["email"], :name => "index_identities_on_email"

  create_table "participators", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "type"
    t.boolean  "attended",   :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "event_id"
  end

  add_index "participators", ["email"], :name => "index_participators_on_email"
  add_index "participators", ["event_id"], :name => "index_participators_on_event_id"
  add_index "participators", ["type"], :name => "index_participators_on_type"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "type"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["type"], :name => "index_users_on_type"

end
