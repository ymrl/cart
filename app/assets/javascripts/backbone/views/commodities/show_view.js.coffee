Cart.Views.Commodities ||= {}

class Cart.Views.Commodities.ShowView extends Backbone.View
  template: JST["backbone/templates/commodities/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
