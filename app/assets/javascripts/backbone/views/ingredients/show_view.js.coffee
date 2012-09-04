Cart.Views.Ingredients ||= {}

class Cart.Views.Ingredients.ShowView extends Backbone.View
  template: JST["backbone/templates/ingredients/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
