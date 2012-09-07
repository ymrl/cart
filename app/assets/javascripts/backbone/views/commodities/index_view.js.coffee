Cart.Views.Commodities ||= {}

class Cart.Views.Commodities.IndexView extends Backbone.View
  template: JST["backbone/templates/commodities/index"]

  initialize: () ->
    @options.commodities.bind('reset', @addAll)
    @options.commodities.bind('add',@addOne)
    @options.commodities.bind('remove',@render)
    @summarizedView = new Cart.Views.Commodities.SummarizedView
      commodities: @options.commodities

  addAll: () =>
    @options.commodities.each(@addOne)

  addOne: (commodity) =>
    view = new Cart.Views.Commodities.CommodityView({model : commodity})
    @$el.find(".detailView .list").append(view.render().el)
    view.bind('changeSize', =>if @scroll then @scroll.refresh() )
    if @scroll then @scroll.refresh()
  render: =>
    $(@el).html(@template(commodities: @options.commodities.toJSON() ))
    @addAll()
    @$el.find('.summarizedView').append(@summarizedView.render().el)
    @scroll = new iScroll(@$el.find(".listWrapper").get(0))
    @scroll.refresh()

    return this
