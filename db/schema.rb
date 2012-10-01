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

ActiveRecord::Schema.define(:version => 20120928044647) do

  create_table "amazon_catalogs", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "application_feedbacks", :force => true do |t|
    t.integer  "user_id"
    t.string   "page"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "books", :force => true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "isbn"
    t.string   "asin"
    t.string   "ean"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "thumbnail_link"
    t.text     "synopsis"
    t.string   "cover_url"
    t.string   "link_to_amzn"
  end

  create_table "books_users", :force => true do |t|
    t.integer "book_id"
    t.integer "user_id"
  end

  create_table "checkouts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.date     "checkout_date"
    t.date     "due_date"
    t.boolean  "returned"
    t.float    "deposit"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "exchange_proposals", :force => true do |t|
    t.integer  "request_id"
    t.datetime "exchange_start"
    t.datetime "exchange_end"
    t.string   "location"
    t.string   "status"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "favorites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "favorite_user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "locations", :force => true do |t|
    t.integer  "user_id"
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "short_name"
    t.boolean  "is_default"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "request_comments", :force => true do |t|
    t.integer  "request_id"
    t.integer  "user_id"
    t.string   "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "requests", :force => true do |t|
    t.integer  "requester_user_id"
    t.integer  "owner_user_id"
    t.integer  "book_id"
    t.string   "status"
    t.integer  "requested_days"
    t.date     "return_date"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "salt"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "profile_picture_file_name"
    t.string   "profile_picture_content_type"
    t.integer  "profile_picture_file_size"
    t.datetime "profile_picture_updated_at"
  end

end
