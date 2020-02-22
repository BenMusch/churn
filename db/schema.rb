# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_22_180223) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.bigint "institution_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["institution_id"], name: "index_cards_on_institution_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.bigint "parent_category_id"
    t.string "plaid_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_category_id"], name: "index_categories_on_parent_category_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.string "plaid_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "linked_accounts", force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.bigint "user_id", null: false
    t.string "name"
    t.string "plaid_id"
    t.string "plaid_type"
    t.string "plaid_subtype"
    t.string "mask"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["institution_id"], name: "index_linked_accounts_on_institution_id"
    t.index ["user_id"], name: "index_linked_accounts_on_user_id"
  end

  create_table "rewards_filter_categories", force: :cascade do |t|
    t.bigint "rewards_filter_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_rewards_filter_categories_on_category_id"
    t.index ["rewards_filter_id"], name: "index_rewards_filter_categories_on_rewards_filter_id"
  end

  create_table "rewards_filters", force: :cascade do |t|
    t.string "vendor_filter", default: ".*"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rewards_percentages", force: :cascade do |t|
    t.bigint "card_id", null: false
    t.bigint "rewards_filter_id", null: false
    t.integer "percent"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["card_id"], name: "index_rewards_percentages_on_card_id"
    t.index ["rewards_filter_id"], name: "index_rewards_percentages_on_rewards_filter_id"
  end

  create_table "rewards_points", force: :cascade do |t|
    t.bigint "card_id", null: false
    t.decimal "points_per_dollar"
    t.bigint "rewards_filter_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "rewards_points_type_id", null: false
    t.index ["card_id"], name: "index_rewards_points_on_card_id"
    t.index ["rewards_filter_id"], name: "index_rewards_points_on_rewards_filter_id"
    t.index ["rewards_points_type_id"], name: "index_rewards_points_on_rewards_points_type_id"
  end

  create_table "rewards_points_payouts", force: :cascade do |t|
    t.decimal "dollars_per_point"
    t.bigint "rewards_points_type_id", null: false
    t.bigint "rewards_filter_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rewards_filter_id"], name: "index_rewards_points_payouts_on_rewards_filter_id"
    t.index ["rewards_points_type_id"], name: "index_rewards_points_payouts_on_rewards_points_type_id"
  end

  create_table "rewards_points_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cards", "institutions"
  add_foreign_key "categories", "categories", column: "parent_category_id"
  add_foreign_key "linked_accounts", "institutions"
  add_foreign_key "linked_accounts", "users"
  add_foreign_key "rewards_filter_categories", "categories"
  add_foreign_key "rewards_filter_categories", "rewards_filters"
  add_foreign_key "rewards_percentages", "cards"
  add_foreign_key "rewards_percentages", "rewards_filters"
  add_foreign_key "rewards_points", "cards"
  add_foreign_key "rewards_points", "rewards_filters"
  add_foreign_key "rewards_points", "rewards_points_types"
  add_foreign_key "rewards_points_payouts", "rewards_filters"
  add_foreign_key "rewards_points_payouts", "rewards_points_types"
end
