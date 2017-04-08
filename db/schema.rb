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

ActiveRecord::Schema.define(version: 20170403104246) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

# Could not dump table "cv_trans" because of following StandardError
#   Unknown type 'lang' for column 'tran_lang'

  create_table "cvs", force: :cascade do |t|
    t.string   "token",      limit: 6
    t.datetime "birthday",             null: false
    t.string   "email",                null: false
    t.string   "phone"
    t.string   "skype",                null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["token"], name: "index_cvs_on_token", using: :btree
  end

  create_table "educations", force: :cascade do |t|
    t.integer  "cv_tran_id"
    t.string   "degree",              null: false
    t.string   "specialty"
    t.string   "institution",         null: false
    t.integer  "year",                null: false
    t.string   "institution_address"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["cv_tran_id"], name: "index_educations_on_cv_tran_id", using: :btree
  end

  create_table "experiences", force: :cascade do |t|
    t.integer  "cv_tran_id"
    t.datetime "started_at",      null: false
    t.datetime "finished_at"
    t.string   "position",        null: false
    t.string   "company",         null: false
    t.string   "company_site"
    t.string   "company_address"
    t.string   "duties",                       array: true
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["cv_tran_id"], name: "index_experiences_on_cv_tran_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.integer  "experience_id"
    t.string   "name",                      null: false
    t.string   "description",   limit: 500
    t.string   "link"
    t.string   "technologies"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["experience_id"], name: "index_projects_on_experience_id", using: :btree
  end

end
