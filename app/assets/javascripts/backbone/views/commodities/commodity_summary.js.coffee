Cart.Views.Commodities ||= {}

class Cart.Views.Commodities.CommoditySummary extends Backbone.View
  template: JST["backbone/templates/commodities/commodity_summary"]
  initialize: (options)->
    super(options)
    @model.bind('change',@render)
  render: =>
    $(@el).html(@template(@model.toJSON() ))
    return this
