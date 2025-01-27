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

ActiveRecord::Schema[7.2].define(version: 2025_01_25_152629) do
  create_table "expense_splits", force: :cascade do |t|
    t.integer "expense_id_id", null: false
    t.integer "payee_id", null: false
    t.integer "amount"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_id_id"], name: "index_expense_splits_on_expense_id_id"
    t.index ["payee_id"], name: "index_expense_splits_on_payee_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.integer "payer_id", null: false
    t.integer "expense_group_id", null: false
    t.integer "amount"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_group_id"], name: "index_expenses_on_expense_group_id"
    t.index ["payer_id"], name: "index_expenses_on_payer_id"
  end

  create_table "group_members", force: :cascade do |t|
    t.integer "group_id_id", null: false
    t.integer "member_id", null: false
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id_id"], name: "index_group_members_on_group_id_id"
    t.index ["member_id"], name: "index_group_members_on_member_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.integer "creator_id", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_groups_on_creator_id"
  end

  create_table "settlements", force: :cascade do |t|
    t.integer "payer_id", null: false
    t.integer "payee_id", null: false
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payee_id"], name: "index_settlements_on_payee_id"
    t.index ["payer_id"], name: "index_settlements_on_payer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "expense_splits", "expenses", column: "expense_id_id"
  add_foreign_key "expense_splits", "users", column: "payee_id"
  add_foreign_key "expenses", "groups", column: "expense_group_id"
  add_foreign_key "expenses", "users", column: "payer_id"
  add_foreign_key "group_members", "groups", column: "group_id_id"
  add_foreign_key "group_members", "users", column: "member_id"
  add_foreign_key "groups", "users", column: "creator_id"
  add_foreign_key "settlements", "users", column: "payee_id"
  add_foreign_key "settlements", "users", column: "payer_id"
end
