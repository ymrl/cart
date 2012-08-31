class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient
  attr_accessible :recipe,:recipe_id,:ingredient,:ingredient_id
end
