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

ActiveRecord::Schema[8.1].define(version: 2026_03_20_053427) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "accepters", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "full_name"
    t.string "id_verified"
    t.string "phone_verified"
    t.integer "quests_completed", default: 0
    t.float "rating_average"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "suburb"
    t.string "trust_tier"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_accepters_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accepters_on_reset_password_token", unique: true
  end

  create_table "givers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "emergency_contact_name"
    t.string "emergency_contact_phone"
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "suburb"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_givers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_givers_on_reset_password_token", unique: true
  end

  create_table "quest_applications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "accepter_id", null: false
    t.datetime "created_at", null: false
    t.text "message"
    t.uuid "quest_id", null: false
    t.string "status", default: "pending", null: false
    t.index ["accepter_id"], name: "index_quest_applications_on_accepter_id"
    t.index ["quest_id"], name: "index_quest_applications_on_quest_id"
  end

  create_table "quests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "accepter_id"
    t.string "address_full"
    t.string "category"
    t.datetime "created_at", null: false
    t.text "description"
    t.datetime "expires_at"
    t.uuid "giver_id", null: false
    t.boolean "is_urgent", default: false
    t.decimal "reward_amount", precision: 10, scale: 2
    t.string "reward_type"
    t.string "status", default: "open", null: false
    t.string "suburb"
    t.string "title", null: false
    t.index ["accepter_id"], name: "index_quests_on_accepter_id"
    t.index ["giver_id"], name: "index_quests_on_giver_id"
  end

  create_table "reviews", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "accepter_id", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.uuid "giver_id", null: false
    t.uuid "quest_id", null: false
    t.integer "rating", null: false
    t.index ["accepter_id"], name: "index_reviews_on_accepter_id"
    t.index ["giver_id"], name: "index_reviews_on_giver_id"
    t.index ["quest_id"], name: "index_reviews_on_quest_id"
  end

  add_foreign_key "quest_applications", "accepters"
  add_foreign_key "quest_applications", "quests"
  add_foreign_key "quests", "accepters"
  add_foreign_key "quests", "givers"
  add_foreign_key "reviews", "accepters"
  add_foreign_key "reviews", "givers"
  add_foreign_key "reviews", "quests"
end
