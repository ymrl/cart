Cart.Views.Recipes ||= {}

class Cart.Views.Recipes.RecipeView extends Backbone.View
  template: JST["backbone/templates/recipes/recipe"]

  events:
    #"click .destroy" : "destroy"
    "click" : "openClose"

  openClose: (e)=>
    @$el.find('.expand').text(if @expand then '▼' else '▲')
    @$el.find('.info').slideToggle 'normal', => @trigger('changeSize')
    @expand = !@expand
  initialize: (option)->
    super(option)
    @model.bind 'change',@render
    @expand = false

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: =>
    $(@el).html(@template(@model.toJSON() ))
    return this
