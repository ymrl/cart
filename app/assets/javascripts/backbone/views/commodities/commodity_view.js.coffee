Cart.Views.Commodities ||= {}

class Cart.Views.Commodities.CommodityView extends Backbone.View
  template: JST["backbone/templates/commodities/commodity"]

  events:
    #"click .destroy" : "destroy"
    "click .expand" : "openClose"
    "click .remove": "remove"

  remove: (e)=>
    console.log @model
    @model.collection.remove(@model)
  openClose: (e)=>
    @$el.find('.expand').text(if @expand then '▼' else '▲')
    @$el.find('.info').slideToggle 'normal', => @trigger('changeSize')
    @expand = !@expand
  initialize: (option)->
    super(option)
    @model.bind 'change',@render
    @expand = false


  render: =>
    $(@el).html(@template(@model.toJSON() ))
    return this
