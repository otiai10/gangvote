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

ActiveRecord::Schema.define(:version => 20130427022705) do

  create_table "adminusers", :force => true do |t|
    t.string   "team",       :null => false
    t.string   "name",       :null => false
    t.string   "password",   :null => false
    t.binary   "info"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "games", :force => true do |t|
    t.string   "hometeam"
    t.string   "awayteam"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "imgurl"
    t.string   "title"
    t.integer  "stadium"
    t.date     "date"
  end

  create_table "players", :force => true do |t|
    t.integer  "number"
    t.string   "name"
    t.string   "kana"
    t.integer  "position"
    t.integer  "grade"
    t.string   "imgurl"
    t.string   "introduction"
    t.binary   "info"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "points"
    t.string   "team"
    t.string   "from"
    t.string   "dept"
    t.string   "sport"
    t.string   "favorite"
    t.string   "reason"
  end

  create_table "votes", :force => true do |t|
    t.integer  "voted_id"
    t.datetime "voted_time"
    t.datetime "ts"
    t.text     "voted_by"
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
