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

ActiveRecord::Schema.define(:version => 20121210174923) do

  create_table "banners", :force => true do |t|
    t.integer  "photo_id"
    t.integer  "pos_x"
    t.integer  "pos_y"
    t.string   "font_color"
    t.string   "bg_color"
    t.integer  "font_size"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.string   "item_code"
    t.string   "mall_code"
    t.string   "url"
    t.integer  "price"
    t.integer  "discount_rate"
    t.integer  "discount_price"
    t.string   "fabric"
    t.string   "laundry"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "photos", :force => true do |t|
    t.string   "photo_file"
    t.integer  "item_id"
    t.integer  "user_id"
    t.string   "item_code"
    t.integer  "part"
    t.integer  "position_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "positions", :force => true do |t|
    t.string   "name"
    t.integer  "template_id"
    t.integer  "part"
    t.integer  "x_pos"
    t.integer  "y_pos"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "templates", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",                     :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end
