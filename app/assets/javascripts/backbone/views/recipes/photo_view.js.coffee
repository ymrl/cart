Cart.Views.Recipes ||= {}

class Cart.Views.Recipes.PhotoView extends Backbone.View
  template: JST["backbone/templates/recipes/photo"]

  initialize: () ->
    @options.recipes.bind('reset', @addAll)
    @options.recipes.bind('add',@addBinder)
    @options.recipes.bind('remove',@render)
    @views = []
    @showing = 0
    @interval = null

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
    if @options.recipes.length > 0
      @$el.find('.recipePhotos').addClass('hasRecipes')
  change: ()=>
    @$el.find('recipePhoto').css('opacity',0)
    if @options.recipes.length == 0 then return
    #next = @showing
    #while next == @showing
    next = Math.floor(Math.random() * @options.recipes.length)
    @$el.find(".recipePhoto#{@options.recipes.models[next].id}").css 'opacity',1
    #@$el.find(".recipePhoto#{@options.recipes.models[@showing].id}").css 'opacity',0
    @showing = next
  render: =>
    if @interval
      window.clearInterval(@interval)
    $(@el).html(@template())

    @addAll()
    @change()
    if @options.recipes.length > 0
      @$el.find('.recipePhotos').addClass('hasRecipes')
    @interval = window.setInterval(@change,5000)

    return this
