Cart.Views.Commodities ||= {}

class Cart.Views.Commodities.IndexView extends Backbone.View
  template: JST["backbone/templates/commodities/index"]

  initialize: () ->
    @options.commodities.bind('reset', @addAll)

  addAll: () =>
    @options.commodities.each(@addOne)

  addOne: (commodity) =>
    view = new Cart.Views.Commodities.CommodityView({model : commodity})
    @$el.find(".detailView .list").append(view.render().el)
    if @scroll then @scroll.refresh()
  render: =>
    $(@el).html(@template(commodities: @options.commodities.toJSON() ))
    @addAll()
    @scroll = new iScroll(@$el.find(".detailView").get(0))
    @scroll.refresh()

    return this
