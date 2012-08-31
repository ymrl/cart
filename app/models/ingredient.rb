class Ingredient < ActiveRecord::Base
  attr_accessible :calcium, :calorie, :carbohydrates, :carotene, :fat, :name, :protein, :vitamin_b1, :vitamin_b2, :vitamin_c
  has_many :recipes
  has_many :recipe_ingredients
end
