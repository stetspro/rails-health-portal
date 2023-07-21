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

ActiveRecord::Schema.define(version: 2023_07_21_155200) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ai_schedulers", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.date "date"
    t.bigint "patient_diagnosis_id", null: false
    t.boolean "has_taken_appointment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_diagnosis_id"], name: "index_ai_schedulers_on_patient_diagnosis_id"
    t.index ["patient_id"], name: "index_ai_schedulers_on_patient_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.bigint "patient_id", null: false
    t.datetime "appointment_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.time "appointment_time"
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
  end

  create_table "diagnoses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_chronic", default: false
  end

  create_table "doctors", force: :cascade do |t|
    t.string "name"
    t.string "specialty"
    t.string "email"
    t.bigint "hospital_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest"
    t.string "remember_token"
    t.index ["hospital_id"], name: "index_doctors_on_hospital_id"
  end

  create_table "hospitals", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "medications", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.string "name"
    t.string "dosage"
    t.string "frequency"
    t.date "expiration_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_id"], name: "index_medications_on_patient_id"
  end

  create_table "patient_diagnoses", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.bigint "diagnosis_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "complaint"
    t.index ["diagnosis_id"], name: "index_patient_diagnoses_on_diagnosis_id"
    t.index ["patient_id"], name: "index_patient_diagnoses_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.date "date_of_birth"
    t.string "email"
    t.text "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest"
    t.string "remember_token"
  end

  add_foreign_key "ai_schedulers", "patient_diagnoses"
  add_foreign_key "ai_schedulers", "patients"
  add_foreign_key "appointments", "doctors"
  add_foreign_key "appointments", "patients"
  add_foreign_key "doctors", "hospitals"
  add_foreign_key "medications", "patients"
  add_foreign_key "patient_diagnoses", "diagnoses"
  add_foreign_key "patient_diagnoses", "patients"
end
