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

ActiveRecord::Schema[8.1].define(version: 2026_03_17_000003) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "quests", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.datetime "due_date"
    t.integer "experience"
    t.string "location"
    t.bigint "quest_accepter_id"
    t.bigint "quest_giver_id", null: false
    t.integer "reward"
    t.string "status", default: "open", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["quest_accepter_id"], name: "index_quests_on_quest_accepter_id"
    t.index ["quest_giver_id"], name: "index_quests_on_quest_giver_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "comment"
    t.datetime "created_at", null: false
    t.bigint "quest_id", null: false
    t.integer "rating", null: false
    t.bigint "reviewee_id", null: false
    t.bigint "reviewer_id", null: false
    t.datetime "updated_at", null: false
    t.index ["quest_id", "reviewer_id"], name: "index_reviews_on_quest_id_and_reviewer_id", unique: true
    t.index ["quest_id"], name: "index_reviews_on_quest_id"
    t.index ["reviewee_id"], name: "index_reviews_on_reviewee_id"
    t.index ["reviewer_id"], name: "index_reviews_on_reviewer_id"
  end

  create_table "users", force: :cascade do |t|
    t.decimal "avg_rating", precision: 3, scale: 2
    t.text "bio"
    t.datetime "created_at", null: false
    t.date "date_of_birth"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role", default: 0, null: false
    t.integer "total_xp", default: 0, null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "quests", "users", column: "quest_accepter_id"
  add_foreign_key "quests", "users", column: "quest_giver_id"
  add_foreign_key "reviews", "quests"
end
