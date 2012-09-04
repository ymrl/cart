class Cart.Routers.IngredientsRouter extends Backbone.Router
  initialize: (options) ->
    @ingredients = new Cart.Collections.IngredientsCollection()
    @ingredients.reset options.ingredients

  routes:
    "/new"      : "newIngredient"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newIngredient: ->
    @view = new Cart.Views.Ingredients.NewView(collection: @ingredients)
    $("#ingredients").html(@view.render().el)

  index: ->
    @view = new Cart.Views.Ingredients.IndexView(ingredients: @ingredients)
    $("#ingredients").html(@view.render().el)

  show: (id) ->
    ingredient = @ingredients.get(id)

    @view = new Cart.Views.Ingredients.ShowView(model: ingredient)
    $("#ingredients").html(@view.render().el)

  edit: (id) ->
    ingredient = @ingredients.get(id)

    @view = new Cart.Views.Ingredients.EditView(model: ingredient)
    $("#ingredients").html(@view.render().el)
