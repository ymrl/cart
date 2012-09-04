Cart.Views.Recipes ||= {}

class Cart.Views.Recipes.RecipeView extends Backbone.View
  template: JST["backbone/templates/recipes/recipe"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
