class Cart.Models.Commodity extends Backbone.Model
  paramRoot: 'commodity'

  defaults:
    jan: null
    price: null
    weight: null
    description: null
    count: 1
  constructor: (option)->
    super(option)
    @recipes = new Cart.Collections.RecipesCollection
  searchRecipes: (callback)=>
    @recipes.searchByIngredient(@get('ingredient_id'),callback)

class Cart.Collections.CommoditiesCollection extends Backbone.Collection
  model: Cart.Models.Commodity
  url: '/commodities'

  addJan: (jan,callback)=>
    for i in @models
      if i.get('jan') is jan
        return i.set 'count',i.get('count') + 1
    @searchByJan(jan,callback)
  searchByJan: (jan,callback)=>
    @fetch
      url: '/commodities/search'
      data:
        jan: jan
      success: (collection,data)=>
        if callback then callback.call(@,collection,data)
