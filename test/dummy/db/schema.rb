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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121014185452) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "publinator_domain_names", :force => true do |t|
    t.boolean  "shared"
    t.boolean  "default"
    t.string   "name"
    t.string   "subdomain"
    t.integer  "site_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "publinator_publication_states", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "publinator_publications", :force => true do |t|
    t.integer  "site_id"
    t.integer  "publication_state_id"
    t.integer  "parent_id"
    t.string   "custom_slug"
    t.string   "slug"
    t.string   "publishable_type"
    t.integer  "publishable_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.datetime "publish_at"
    t.datetime "unpublish_at"
    t.datetime "archive_at"
  end

  create_table "publinator_publishable_types", :force => true do |t|
    t.string   "name"
    t.string   "sluggable",  :default => "t"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "publinator_publishables", :force => true do |t|
    t.integer  "publication_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "publinator_sections", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.boolean  "layout"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "publinator_site_workflows", :force => true do |t|
    t.integer  "site_id"
    t.integer  "workflow_id"
    t.string   "publishable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "publinator_sites", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.integer  "parent_id"
    t.string   "state"
    t.string   "abbr"
    t.string   "type"
    t.boolean  "default"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "publinator_workflow_steps", :force => true do |t|
    t.integer  "workflow_id"
    t.integer  "position"
    t.string   "role"
    t.boolean  "notify"
    t.boolean  "require"
    t.string   "publishable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "publinator_workflows", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
