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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140416035618) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calendar_days", force: true do |t|
    t.integer  "calendar_id"
    t.date     "day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "calendar_days", ["calendar_id"], name: "index_calendar_days_on_calendar_id", using: :btree

  create_table "calendars", force: true do |t|
    t.integer  "company_id"
    t.date     "date_start"
    t.date     "date_end"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "closed",     default: false
  end

  add_index "calendars", ["company_id"], name: "index_calendars_on_company_id", using: :btree

  create_table "classrooms", force: true do |t|
    t.string   "name"
    t.integer  "course_id"
    t.integer  "company_id"
    t.integer  "day_week"
    t.time     "time_start"
    t.time     "time_end"
    t.integer  "teacher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "capacity",    default: 0
    t.integer  "calendar_id"
    t.boolean  "closed",      default: false
  end

  add_index "classrooms", ["company_id"], name: "index_classrooms_on_company_id", using: :btree
  add_index "classrooms", ["course_id"], name: "index_classrooms_on_course_id", using: :btree
  add_index "classrooms", ["teacher_id"], name: "index_classrooms_on_teacher_id", using: :btree

  create_table "companies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vacancy",                 default: 0
    t.string   "street",       limit: 50
    t.string   "house_number", limit: 8
    t.string   "complement",   limit: 20
    t.string   "zip_code",     limit: 10
    t.string   "neighborhood", limit: 50
    t.string   "city",         limit: 50
    t.integer  "federal_unit"
    t.string   "email"
    t.string   "phone"
  end

  create_table "courses", force: true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "type_course", default: 0
  end

  add_index "courses", ["company_id"], name: "index_courses_on_company_id", using: :btree

  create_table "events", force: true do |t|
    t.integer  "calendar_day_id"
    t.text     "description"
    t.integer  "type_event"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "time_start"
    t.time     "time_end"
    t.integer  "teacher_id"
    t.integer  "student_id"
    t.boolean  "closed",          default: false
  end

  add_index "events", ["calendar_day_id"], name: "index_events_on_calendar_day_id", using: :btree

  create_table "exams", force: true do |t|
    t.integer  "lesson_id"
    t.integer  "group_id"
    t.string   "name"
    t.float    "value"
    t.integer  "type_exam"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exams", ["group_id"], name: "index_exams_on_group_id", using: :btree
  add_index "exams", ["lesson_id"], name: "index_exams_on_lesson_id", using: :btree

  create_table "faults", force: true do |t|
    t.integer  "group_id"
    t.integer  "lesson_id"
    t.integer  "justification", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "faults", ["group_id"], name: "index_faults_on_group_id", using: :btree
  add_index "faults", ["lesson_id"], name: "index_faults_on_lesson_id", using: :btree

  create_table "groups", force: true do |t|
    t.integer  "student_id"
    t.integer  "classroom_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "new_classroom_id"
    t.text     "justification"
  end

  add_index "groups", ["classroom_id"], name: "index_groups_on_classroom_id", using: :btree
  add_index "groups", ["student_id"], name: "index_groups_on_student_id", using: :btree

  create_table "lessons", force: true do |t|
    t.integer  "classroom_id"
    t.integer  "calendar_day_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lessons", ["calendar_day_id"], name: "index_lessons_on_calendar_day_id", using: :btree
  add_index "lessons", ["classroom_id"], name: "index_lessons_on_classroom_id", using: :btree

  create_table "notes", force: true do |t|
    t.integer  "company_id"
    t.text     "subject"
    t.integer  "for_note"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["company_id"], name: "index_notes_on_company_id", using: :btree
  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

  create_table "students", force: true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "street",       limit: 50
    t.string   "house_number", limit: 8
    t.string   "complement",   limit: 20
    t.string   "zip_code",     limit: 10
    t.string   "neighborhood", limit: 50
    t.string   "city",         limit: 50
    t.integer  "federal_unit"
    t.string   "email"
    t.date     "birth_date"
    t.string   "phone"
    t.text     "obs"
    t.string   "document"
  end

  add_index "students", ["company_id"], name: "index_students_on_company_id", using: :btree

  create_table "teachers", force: true do |t|
    t.string   "name"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teachers", ["company_id"], name: "index_teachers_on_company_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name",                   default: "",   null: false
    t.string   "profile",                default: "",   null: false
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "timeout_in",             default: 1800, null: false
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,    null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "student_id"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  add_foreign_key "calendar_days", "calendars", name: "calendar_days_calendar_id_fk"

  add_foreign_key "calendars", "companies", name: "calendars_company_id_fk"

  add_foreign_key "classrooms", "calendars", name: "classrooms_calendar_id_fk"
  add_foreign_key "classrooms", "companies", name: "classrooms_company_id_fk"
  add_foreign_key "classrooms", "courses", name: "classrooms_course_id_fk"
  add_foreign_key "classrooms", "teachers", name: "classrooms_teacher_id_fk"

  add_foreign_key "courses", "companies", name: "courses_company_id_fk"

  add_foreign_key "events", "calendar_days", name: "events_calendar_day_id_fk"
  add_foreign_key "events", "students", name: "events_student_id_fk"
  add_foreign_key "events", "teachers", name: "events_teacher_id_fk"

  add_foreign_key "exams", "groups", name: "exams_group_id_fk"
  add_foreign_key "exams", "lessons", name: "exams_lesson_id_fk"

  add_foreign_key "faults", "groups", name: "faults_group_id_fk"
  add_foreign_key "faults", "lessons", name: "faults_lesson_id_fk"

  add_foreign_key "groups", "classrooms", name: "groups_classroom_id_fk"
  add_foreign_key "groups", "students", name: "groups_student_id_fk"

  add_foreign_key "lessons", "calendar_days", name: "lessons_calendar_day_id_fk"
  add_foreign_key "lessons", "classrooms", name: "lessons_classroom_id_fk"

  add_foreign_key "notes", "companies", name: "notes_company_id_fk"
  add_foreign_key "notes", "users", name: "notes_user_id_fk"

  add_foreign_key "students", "companies", name: "students_company_id_fk"

  add_foreign_key "teachers", "companies", name: "teachers_company_id_fk"

  add_foreign_key "users", "students", name: "users_student_id_fk"

end
