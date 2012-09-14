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

ActiveRecord::Schema.define(:version => 20120914013200) do

  create_table "fantasy_leagues", :force => true do |t|
    t.string   "name"
    t.integer  "espn_id"
    t.integer  "year"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "fantasy_teams", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "fantasy_league_id"
    t.integer  "espn_id"
  end

  create_table "fantasy_teams_players", :id => false, :force => true do |t|
    t.integer "fantasy_team_id"
    t.integer "player_id"
    t.boolean "starter"
  end

  create_table "injuries", :force => true do |t|
    t.integer  "player_id"
    t.integer  "week"
    t.string   "injury_desc"
    t.string   "practice_status_desc"
    t.string   "game_status_desc"
    t.datetime "last_update"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.string   "position"
    t.string   "team"
    t.integer  "ffn_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projections", :force => true do |t|
    t.integer  "player_id"
    t.integer  "rank"
    t.integer  "week"
    t.decimal  "standard"
    t.decimal  "standard_low"
    t.decimal  "standard_high"
    t.decimal  "ppr"
    t.decimal  "ppr_low"
    t.decimal  "ppr_high"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
