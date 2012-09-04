class Cart.Models.Recipe extends Backbone.Model
  paramRoot: 'recipe'

  defaults:
    title: null
    image: null
    calorie: null
    time: null
    count: 1

class Cart.Collections.RecipesCollection extends Backbone.Collection
  model: Cart.Models.Recipe
  url: '/recipes'
  searchByIngredient: (ingredientId,callback)=>
    @fetch
      url:'/recipes/search'
      data:
        ingredient_id: ingredientId
      success: (collection,data)=>
        if callback then callback.call(@,collection,data)

    
