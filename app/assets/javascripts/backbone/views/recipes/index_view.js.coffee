Cart.Views.Recipes ||= {}

class Cart.Views.Recipes.IndexView extends Backbone.View
  template: JST["backbone/templates/recipes/index"]

  initialize: () ->
    @options.recipes.bind('reset', @addAll)
    @options.recipes.bind('change',@sort)
    @views = []
  sort: ()=>
    @views = @views.sort (a,b)->return b.model.get('count') - a.model.get('count')
    for view in @views
      @$(".detailView .list").append(view.el)

  addAll: () =>
    @options.recipes.each(@addOne)

  addOne: (recipe) =>
    view = new Cart.Views.Recipes.RecipeView({model : recipe})
    @$(".detailView .list").append(view.render().el)
    @views.push view
    if @scroll then @scroll.refresh()

  render: =>
    $(@el).html(@template(recipes: @options.recipes.toJSON() ))
    @addAll()
    @scroll = new iScroll(@$(".detailView").get(0))
    @scroll.refresh()

    return this
