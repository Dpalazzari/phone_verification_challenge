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

ActiveRecord::Schema[7.0].define(version: 2023_03_03_181610) do
  create_table "phones", force: :cascade do |t|
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_phones_on_number"
  end

  create_table "tokens", force: :cascade do |t|
    t.string "body"
    t.datetime "expiration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "verification_id"
    t.index ["body"], name: "index_tokens_on_body"
    t.index ["verification_id"], name: "index_tokens_on_verification_id"
  end

  create_table "traits", force: :cascade do |t|
    t.string "slug"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_traits_on_slug"
  end

  create_table "verifications", force: :cascade do |t|
    t.string "verificationable_type"
    t.integer "verificationable_id"
    t.boolean "verified", default: false
    t.datetime "expiration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["verificationable_type", "verificationable_id"], name: "index_verifications_on_verificationable"
  end

end
