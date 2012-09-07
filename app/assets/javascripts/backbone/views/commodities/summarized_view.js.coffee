Cart.Views.Commodities ||= {}

class Cart.Views.Commodities.SummarizedView extends Backbone.View
  template: JST["backbone/templates/commodities/summarized"]

  initialize: () ->
    @options.commodities.bind('reset', @addAll)
    @options.commodities.bind('add',@render)
    @options.commodities.bind('remove',@render)

  addAll: () =>
    @options.commodities.each(@addOne)

  addOne: (commodity) =>
    view = new Cart.Views.Commodities.CommoditySummary({model : commodity})
    @$("ul").append(view.render().el)
  render: =>
    $(@el).html(@template(commodities: @options.commodities.toJSON() ))
    @addAll()

    return this

