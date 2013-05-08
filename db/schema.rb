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

ActiveRecord::Schema.define(:version => 20130508175905) do

  create_table "copy_targets", :force => true do |t|
    t.string   "path"
    t.integer  "prio"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "images", :force => true do |t|
    t.string   "name"
    t.string   "file_name"
    t.string   "path",        :limit => 1000
    t.string   "directory"
    t.string   "file_type"
    t.datetime "last_change"
    t.datetime "last_visit"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "images", ["path"], :name => "index_images_on_path", :unique => true

  create_table "order_contents", :force => true do |t|
    t.integer "order_id"
    t.integer "order_item_id"
  end

  create_table "order_item_images", :force => true do |t|
    t.integer "image_id"
    t.integer "order_item_id"
  end

  create_table "order_items", :force => true do |t|
    t.string   "file_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "key"
    t.string   "name"
    t.string   "login"
    t.integer  "count"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "scan_paths", :force => true do |t|
    t.string   "path"
    t.integer  "interval"
    t.boolean  "active"
    t.datetime "last_visit"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
