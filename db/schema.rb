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

ActiveRecord::Schema.define(:version => 20120527095406) do

  create_table "boot_sizes", :force => true do |t|
    t.string   "size"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "boots", :force => true do |t|
    t.integer  "number"
    t.string   "brand"
    t.string   "condition"
    t.integer  "store_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.boolean  "in_store"
    t.boolean  "available"
    t.integer  "boot_size_id"
  end

  create_table "customers", :force => true do |t|
    t.integer  "store_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "country"
    t.string   "phone"
    t.string   "hotel"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "packages", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "ski_id"
    t.integer  "boot_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "status",      :limit => 25
  end

  create_table "rentals", :force => true do |t|
    t.integer  "package_id"
    t.datetime "time"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "in_or_out",  :limit => 25
  end

  create_table "ski_sizes", :force => true do |t|
    t.string   "size"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "skis", :force => true do |t|
    t.integer  "number"
    t.string   "brand"
    t.string   "condition"
    t.integer  "store_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.boolean  "in_store"
    t.boolean  "available"
    t.integer  "ski_size_id"
  end

  create_table "stores", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.string   "store_name"
    t.string   "owner_first_name"
    t.string   "owner_last_name"
    t.string   "country"
    t.string   "city"
    t.string   "phone"
  end

  add_index "stores", ["email"], :name => "index_stores_on_email", :unique => true
  add_index "stores", ["reset_password_token"], :name => "index_stores_on_reset_password_token", :unique => true

end
