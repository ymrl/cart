Cart.Views.Nutrition ||= {}

class Cart.Views.Nutrition.IndexView extends Backbone.View
  template: JST["backbone/templates/nutrition/index"]

  initialize: () ->
    #@options.commodities.bind('reset', @addAll)
    #@options.commodities.bind('add',@addOne)
    @options.commodities.bind('change',@render)

  #addAll: () =>
  #  @options.commodities.each(@addOne)

  #addOne: (commodity) =>
  #  view = new Cart.Views.Commodities.CommodityView({model : commodity})
  #  @$el.find(".detailView .list").append(view.render().el)
  #  if @scroll then @scroll.refresh()
  render: =>
    $(@el).html(@template(commodities: @options.commodities.toJSON() ))
    @addAll()
    @scroll = new iScroll(@$el.find(".listWrapper").get(0))
    @scroll.refresh()

    return this
