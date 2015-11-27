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

ActiveRecord::Schema.define(version: 20151127224022) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.text     "api_token",  null: false
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "accounts", ["api_token"], name: "index_accounts_on_api_token", using: :btree

  create_table "raw_test_runs", force: :cascade do |t|
    t.jsonb    "payload"
    t.integer  "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "raw_test_runs", ["account_id"], name: "index_raw_test_runs_on_account_id", using: :btree
  add_index "raw_test_runs", ["payload"], name: "index_raw_test_runs_on_payload", using: :gin

  add_foreign_key "raw_test_runs", "accounts"
       create_view :test_results, sql_definition:<<-SQL
         WITH raw_results AS (
        SELECT jsonb_array_elements(raw_test_runs.payload) AS result,
           raw_test_runs.account_id,
           raw_test_runs.created_at,
           raw_test_runs.updated_at
          FROM raw_test_runs
       )
SELECT (raw_results.result ->> 'name'::text) AS name,
   (raw_results.result ->> 'status'::text) AS status,
   ((raw_results.result ->> 'run_time'::text))::double precision AS runtime,
   raw_results.account_id,
   raw_results.created_at,
   raw_results.updated_at
  FROM raw_results;
       SQL

end
