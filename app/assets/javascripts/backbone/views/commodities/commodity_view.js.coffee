Cart.Views.Commodities ||= {}

class Cart.Views.Commodities.CommodityView extends Backbone.View
  template: JST["backbone/templates/commodities/commodity"]

  events:
    "click .expand" : "openClose"
    "click .remove":  "remove"
    "click .plus":    "plus"
    "click .minus":   "minus"
    "click .favorite": "favorite"

  favorite: (e)=>
    @model.set('favorites',@model.get('favorites') + 1)
    @$el.find('.favoritesCount').text(@model.get('favorites'))
    @model.favorite()
    $('#hiddenField').focus()
  plus: (e)=>
    @model.set('count',@model.get('count') + 1)
    $('#hiddenField').focus()
  minus: (e)=>
    count = @model.get('count')
    if count > 1
      @model.set('count',count - 1)
    else
      @model.collection.remove(@model)
    $('#hiddenField').focus()
  remove: (e)=>
    @model.collection.remove(@model)
    $('#hiddenField').focus()
  openClose: (e)=>
    @$el.find('.expand').text(if @expand then '▼' else '▲')
    @$el.find('.info').slideToggle 'normal', => @trigger('changeSize')
    @expand = !@expand
    $('#hiddenField').focus()
  initialize: (option)->
    super(option)
    @model.bind 'change',@render
    @expand = false


  render: =>
    $(@el).html(@template(@model.toJSON() ))
    if @expand
      @$el.find('.info').show()
      @$el.find('.expand').text('▲')
    return this
