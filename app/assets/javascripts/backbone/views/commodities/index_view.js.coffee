Cart.Views.Commodities ||= {}

class Cart.Views.Commodities.IndexView extends Backbone.View
  template: JST["backbone/templates/commodities/index"]

  initialize: () ->
    @options.commodities.bind('reset', @addAll)
    @options.commodities.bind('add',@addBinder)
    @options.commodities.bind('remove',@render)
    @options.commodities.bind('change',@priceRewrite)
    @summarizedView = new Cart.Views.Commodities.SummarizedView
      commodities: @options.commodities

  priceRewrite: ()=>
    @$el.find('.totalPrice').text(@options.commodities.getTotalPrice())
  addBinder: (commodity)=>
    @addOne commodity
    @priceRewrite()

  addAll: () =>
    @options.commodities.each(@addOne)

  addOne: (commodity) =>
    view = new Cart.Views.Commodities.CommodityView({model : commodity})
    @$el.find(".detailView .list").append(view.render().el)
    view.bind('changeSize', =>if @scroll then @scroll.refresh() )
    if @scroll
      @scroll.refresh()
      if @scroll.scrollerH > @scroll.wrapperH
        @scroll.scrollTo(0,- @scroll.scrollerH + @scroll.wrapperH)
    @$el.find('.holder').hide()
    
  render: =>
    data =
      commodities: @options.commodities.toJSON()
    $(@el).html(@template(data ))
    @addAll()
    @$el.find('.summarizedView').append(@summarizedView.render().el)
    @priceRewrite()
    if @options.commodities.length == 0
      @$el.find('.holder').show()
    else
      @$el.find('.holder').hide()

    @scroll = new iScroll(@$el.find(".listWrapper").get(0))
    @scroll.refresh()

    return this
