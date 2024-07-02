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

ActiveRecord::Schema[7.0].define(version: 2024_07_01_225942) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "story_source", ["hacker_news"]

  create_table "flags", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "story_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["story_id"], name: "index_flags_on_story_id"
    t.index ["user_id"], name: "index_flags_on_user_id"
  end

  create_table "stories", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.enum "source", default: "hacker_news", null: false, enum_type: "story_source"
    t.integer "source_id"
    t.boolean "is_top_story", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rank"
    t.integer "flags_count", default: 0, null: false
    t.index ["source", "source_id"], name: "index_stories_on_source_and_source_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "flags", "stories"
  add_foreign_key "flags", "users"
  create_trigger("flags_after_insert_row_tr", :generated => true, :compatibility => 1).
      on("flags").
      after(:insert) do
    <<-SQL_ACTIONS
    UPDATE stories
    SET flags_count = (
      SELECT COUNT(1) FROM flags WHERE story_id = NEW.story_id
    ) WHERE id = NEW.story_id;
    SQL_ACTIONS
  end

  create_trigger("flags_before_delete_row_tr", :generated => true, :compatibility => 1).
      on("flags").
      before(:delete) do
    <<-SQL_ACTIONS
    UPDATE stories
    SET flags_count = (
      SELECT GREATEST(
        (SELECT COUNT(id) FROM flags WHERE story_id = OLD.story_id) -1,
        0
      )
    ) WHERE id = OLD.story_id;
    SQL_ACTIONS
  end

end
