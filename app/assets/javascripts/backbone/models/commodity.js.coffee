class Cart.Models.Commodity extends Backbone.Model
  paramRoot: 'commodity'

  defaults:
    jan: null
    price: null
    ingredient: null
    weight: null
    description: null

class Cart.Collections.CommoditiesCollection extends Backbone.Collection
  model: Cart.Models.Commodity
  url: '/commodities'
