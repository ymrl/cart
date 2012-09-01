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

ActiveRecord::Schema.define(:version => 20120901100345) do

  create_table "commodities", :force => true do |t|
    t.string   "jan"
    t.integer  "price"
    t.integer  "ingredient_id"
    t.float    "weight"
    t.text     "description"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "producer"
  end

  add_index "commodities", ["ingredient_id"], :name => "index_commodities_on_ingredient_id"

  create_table "ingredients", :force => true do |t|
    t.string   "name"
    t.float    "calorie"
    t.float    "carbohydrates"
    t.float    "protein"
    t.float    "fat"
    t.float    "carotene"
    t.float    "vitamin_b1"
    t.float    "vitamin_b2"
    t.float    "vitamin_c"
    t.float    "calcium"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "materials", :force => true do |t|
    t.integer  "recipe_id"
    t.string   "name"
    t.string   "amount"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "materials", ["recipe_id"], :name => "index_materials_on_recipe_id"

  create_table "recipe_ingredients", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "ingredient_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "recipe_ingredients", ["ingredient_id"], :name => "index_recipe_ingredients_on_ingredient_id"
  add_index "recipe_ingredients", ["recipe_id"], :name => "index_recipe_ingredients_on_recipe_id"

  create_table "recipes", :force => true do |t|
    t.string   "title"
    t.string   "image"
    t.string   "url"
    t.string   "time"
    t.float    "calorie"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
