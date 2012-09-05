Cart.Views.Recipes ||= {}

class Cart.Views.Recipes.PhotoView extends Backbone.View
  template: JST["backbone/templates/recipes/photo"]

  initialize: () ->
    @options.recipes.bind('reset', @addAll)
    @options.recipes.bind('add',@addBinder)
    @views = []
    @showing = 0
    setInterval(@change,5000)

  addBinder: ()=>
    for i in @options.recipes.models
      if @$el.find(".recipePhoto#{i.id}").length == 0
        @addOne i
  addAll: () =>
    @options.recipes.each(@addOne)

  addOne: (recipe) =>
    view = new Cart.Views.Recipes.RecipePhoto
      model: recipe
    @$el.find('.recipePhotos').append(view.render().el)
    view.$el.addClass("recipePhoto#{recipe.id}")
  change: ()=>
    photos = @$el.find('.recipePhoto')
    if photos.length == 0 then return
    next = @showing
    while next == @showing
      next = Math.floor(Math.random() * photos.length)
    photos.eq(next).css 'opacity',1
    photos.eq(@showing).css 'opacity',0
    @showing = next
  render: =>
    $(@el).html(@template())
    @addAll()

    return this
