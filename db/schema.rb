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

ActiveRecord::Schema.define(version: 20180925211834) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "committers", force: :cascade do |t|
    t.string "repo", limit: 100
    t.string "author", limit: 39
    t.integer "total"
    t.integer "place"
    t.integer "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repo", "author", "place"], name: "index_committers_on_repo_and_author_and_place", unique: true
    t.index ["stock", "place"], name: "index_committers_on_stock_and_place"
  end

end
