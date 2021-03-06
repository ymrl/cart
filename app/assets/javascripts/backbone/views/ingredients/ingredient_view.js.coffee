Cart.Views.Ingredients ||= {}

class Cart.Views.Ingredients.IngredientView extends Backbone.View
  template: JST["backbone/templates/ingredients/ingredient"]

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
