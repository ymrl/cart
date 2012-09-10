Cart.Views.Recipes ||= {}

class Cart.Views.Recipes.IndexView extends Backbone.View
  template: JST["backbone/templates/recipes/index"]

  initialize: () ->
    @options.recipes.bind('reset', @addAll)
    @options.recipes.bind('change',@sort)
    @options.recipes.bind('changeAndRemove',@render)
    @views = []
    @photoView = new Cart.Views.Recipes.PhotoView
      recipes: @options.recipes
  sort: ()=>
    @views = @views.sort (a,b)->return b.model.get('count') - a.model.get('count')
    for view in @views
      @$(".detailView .list").append(view.el)


  addAll: () =>
    @options.recipes.each(@addOne)

  addOne: (recipe) =>
    view = new Cart.Views.Recipes.RecipeView({model : recipe})
    @$(".detailView .list").append(view.render().el)
    view.bind('changeSize', =>if @scroll then @scroll.refresh() )
    @views.push view
    if @scroll then @scroll.refresh()
    @$el.find('.holder').hide()

  render: =>
    @views = []
    $(@el).html(@template(recipes: @options.recipes.toJSON() ))
    @addAll()
    @sort()
    if @options.recipes.length == 0
      @$el.find('.holder').show()

    @$el.find('.summarizedView').append(@photoView.render().el)
    @scroll = new iScroll(@$(".listWrapper").get(0))
    @scroll.refresh()

    return this
