# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_02_03_001624) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "characters", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "physical_description", null: false
    t.string "behavioral_description", null: false
    t.integer "health", default: 100, null: false
    t.integer "max_health", default: 100, null: false
    t.integer "energy", default: 100, null: false
    t.integer "max_energy", default: 100, null: false
    t.integer "strength", default: 1, null: false
    t.integer "dexterity", default: 1, null: false
    t.integer "intelligence", default: 1, null: false
    t.uuid "room_id", null: false
    t.integer "x", null: false
    t.integer "y", null: false
    t.uuid "user_id", null: false
    t.jsonb "meta", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_characters_on_room_id"
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "chat_messages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "character_id"
    t.string "channel", null: false
    t.text "body", null: false
    t.jsonb "tags", default: [], null: false
    t.jsonb "meta", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_chat_messages_on_character_id"
    t.index ["user_id"], name: "index_chat_messages_on_user_id"
  end

  create_table "loots", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.uuid "character_id"
    t.uuid "room_id"
    t.integer "x"
    t.integer "y"
    t.jsonb "meta", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_loots_on_character_id"
    t.index ["room_id"], name: "index_loots_on_room_id"
  end

  create_table "rooms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.integer "width", default: 10, null: false
    t.integer "height", default: 10, null: false
    t.uuid "room_east_id"
    t.uuid "room_west_id"
    t.uuid "room_south_id"
    t.uuid "room_north_id"
    t.jsonb "meta", default: {}, null: false
    t.index ["room_east_id"], name: "index_rooms_on_room_east_id"
    t.index ["room_north_id"], name: "index_rooms_on_room_north_id"
    t.index ["room_south_id"], name: "index_rooms_on_room_south_id"
    t.index ["room_west_id"], name: "index_rooms_on_room_west_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", default: "Friend", null: false
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.boolean "super", default: false, null: false
    t.uuid "current_character_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.jsonb "meta", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["current_character_id"], name: "index_users_on_current_character_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "characters", "rooms"
  add_foreign_key "characters", "users"
  add_foreign_key "chat_messages", "characters"
  add_foreign_key "chat_messages", "users"
  add_foreign_key "loots", "characters"
  add_foreign_key "loots", "rooms"
  add_foreign_key "rooms", "rooms", column: "room_east_id"
  add_foreign_key "rooms", "rooms", column: "room_north_id"
  add_foreign_key "rooms", "rooms", column: "room_south_id"
  add_foreign_key "rooms", "rooms", column: "room_west_id"
end
