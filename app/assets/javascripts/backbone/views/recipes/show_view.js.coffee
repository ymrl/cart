Cart.Views.Recipes ||= {}

class Cart.Views.Recipes.ShowView extends Backbone.View
  template: JST["backbone/templates/recipes/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
