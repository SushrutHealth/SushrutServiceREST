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

ActiveRecord::Schema.define(:version => 20120201013437) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "artists", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "echonest_id"
    t.text     "images"
    t.text     "biographies"
    t.decimal  "popularity",  :precision => 15, :scale => 10, :default => 0.0
    t.decimal  "familiarity", :precision => 15, :scale => 10, :default => 0.0
  end

  add_index "artists", ["name"], :name => "index_artists_on_name", :unique => true

  create_table "artists_videos", :id => false, :force => true do |t|
    t.integer "artist_id"
    t.integer "video_id"
  end

  add_index "artists_videos", ["artist_id", "video_id"], :name => "index_artists_videos_on_artist_id_and_video_id"

  create_table "authentications", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mentions", :force => true do |t|
    t.integer  "source_id"
    t.text     "text"
    t.string   "url"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "video_id"
    t.string   "title"
  end

  add_index "mentions", ["url"], :name => "index_mentions_on_url", :unique => true

  create_table "sources", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "feeds"
    t.integer  "popularity"
  end

  add_index "sources", ["name"], :name => "index_sources_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "twitter_handle"
    t.string   "facebook_link"
    t.text     "twitter_avatar"
  end

  create_table "users_videos", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "video_id"
  end

  create_table "videos", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video_id"
    t.string   "provider"
    t.text     "description"
    t.text     "keywords"
    t.integer  "duration"
    t.datetime "date"
    t.string   "thumbnail_small"
    t.string   "thumbnail_large"
    t.integer  "width"
    t.integer  "height"
    t.integer  "popularity"
  end

  add_index "videos", ["title"], :name => "index_videos_on_title", :unique => true
  add_index "videos", ["url"], :name => "index_videos_on_url", :unique => true

end
