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

ActiveRecord::Schema[8.1].define(version: 2026_01_22_152805) do
  create_table "announcements", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "parent_students", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "parent_id", null: false
    t.integer "student_id", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_parent_students_on_parent_id"
    t.index ["student_id"], name: "index_parent_students_on_student_id"
  end

  create_table "scores", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "score"
    t.integer "student_id", null: false
    t.string "subject"
    t.string "term"
    t.string "test_type"
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_scores_on_student_id"
  end

  create_table "student_profiles", force: :cascade do |t|
    t.boolean "active"
    t.datetime "created_at", null: false
    t.integer "grade"
    t.string "school_name"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_student_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "withdrawals", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "reason"
    t.integer "student_id", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_withdrawals_on_student_id"
  end

  add_foreign_key "parent_students", "parents"
  add_foreign_key "parent_students", "students"
  add_foreign_key "scores", "students"
  add_foreign_key "student_profiles", "users"
  add_foreign_key "withdrawals", "students"
end
