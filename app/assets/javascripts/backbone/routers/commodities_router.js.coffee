class Cart.Routers.CommoditiesRouter extends Backbone.Router
  initialize: (options) ->
    @commodities = new Cart.Collections.CommoditiesCollection()
    @commodities.reset options.commodities

  routes:
    "/new"      : "newCommodity"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newCommodity: ->
    @view = new Cart.Views.Commodities.NewView(collection: @commodities)
    $("#commodities").html(@view.render().el)

  index: ->
    @view = new Cart.Views.Commodities.IndexView(commodities: @commodities)
    $("#commodities").html(@view.render().el)

  show: (id) ->
    commodity = @commodities.get(id)

    @view = new Cart.Views.Commodities.ShowView(model: commodity)
    $("#commodities").html(@view.render().el)

  edit: (id) ->
    commodity = @commodities.get(id)

    @view = new Cart.Views.Commodities.EditView(model: commodity)
    $("#commodities").html(@view.render().el)
