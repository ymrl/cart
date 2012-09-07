Cart.Views.Commodities ||= {}

class Cart.Views.Commodities.CommodityView extends Backbone.View
  template: JST["backbone/templates/commodities/commodity"]

  events:
    #"click .destroy" : "destroy"
    "click" : "openClose"
  openClose: (e)=>
    @$el.find('.info').slideToggle 'normal', => @trigger('changeSize')
  initialize: (option)->
    super(option)
    @model.bind 'change',@render


  render: =>
    $(@el).html(@template(@model.toJSON() ))
    return this
