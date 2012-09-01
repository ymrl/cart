class Cart.Models.Ingredient extends Backbone.Model
  paramRoot: 'ingredient'

  defaults:
    name: null
    calorie: null
    carbohydrates: null
    protein: null
    fat: null
    carotene: null
    vitamin_b1: null
    vitamin_b2: null
    vitamin_c: null
    calcium: null

class Cart.Collections.IngredientsCollection extends Backbone.Collection
  model: Cart.Models.Ingredient
  url: '/ingredients'
