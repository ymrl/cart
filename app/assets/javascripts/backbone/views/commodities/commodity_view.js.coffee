Cart.Views.Commodities ||= {}

class Cart.Views.Commodities.CommodityView extends Backbone.View
  template: JST["backbone/templates/commodities/commodity"]

  events:
    "click .destroy" : "destroy"
  initialize: (option)->
    super(option)
    @model.bind 'change',@render

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: =>
    $(@el).html(@template(@model.toJSON() ))
    return this
