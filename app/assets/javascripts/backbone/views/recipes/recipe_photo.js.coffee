Cart.Views.Recipes ||= {}

class Cart.Views.Recipes.RecipePhoto extends Backbone.View
  template: JST["backbone/templates/recipes/recipe_photo"]
  initialize: (option)->super(option)
  render: =>
    @$el.html(@template(@model.toJSON()))
    @$el.addClass('recipePhoto')
    return @
  
