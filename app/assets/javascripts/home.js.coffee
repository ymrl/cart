# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
window.debug ||= {}
$ ->
  buffer = ""
  recipes = new Cart.Collections.RecipesCollection
  recipesView = new Cart.Views.Recipes.IndexView
    recipes: recipes
  $('#recipes').append(recipesView.render().el)

  commodities = new Cart.Collections.CommoditiesCollection
  commoditiesView = new Cart.Views.Commodities.IndexView
    commodities: commodities
  $('#commodities').append(commoditiesView.render().el)

  nutritionView = new Cart.Views.Nutrition.IndexView
    commodities: commodities
  $('#nutrition').append(nutritionView.render().el)

  $('#hiddenForm').submit (e)->
    e.preventDefault()
    commodities.addJan $('#hiddenField').val(),(collection,data)->
      collection.get(data.id).searchRecipes (collection,data)->
        for recipe in collection.models
          exist = recipes.get(recipe.id)
          if exist
            exist.set('count',exist.get('count') + 1)
          else
            recipes.add(recipe)
            recipesView.addOne(recipe)
      collection.get(data.id).bind 'remove',(commodity,collection,data)->
        console.log('remove',commodity,collection)
        for recipe in commodity.recipes.models
          console.log(recipe)
          count = recipe.get('count')
          if(count > 1)
            recipe.set('count',count - 1)
          else
            recipes.remove(recipe)
      
    $('#hiddenField').val('')

  window.debug.commodities = commodities
  window.debug.recipes     = recipes
  window.debug.recipesView = recipesView
  window.debug.commoditiesView = commoditiesView
  

  invisibleLayer = $('<div>').appendTo('body').attr('id','invisibleLayer')
  invisibleLayer.css
    width:  $(window).outerWidth()
    height: $(window).outerHeight()
    position: 'absolute'
    top:0
    left:0
    zIndex:-1
  $('#content').click (e)->
    $('#hiddenField').focus()
  $('#content .containerInner').click (e)->
    t = $(@)
    if !t.hasClass('open')
      $('.open').removeClass('open')
      t.addClass('open')

  $.getJSON '/commodities',{},(data)->
    for i in data
      $('<option>').text(i.name).val(i.jan).appendTo($('#debugSelectIngredient'))

  $('#debugForm').submit (e)->
    e.preventDefault()
    v = $('#debugSelectIngredient').val()
    if v != "none"
      $('#hiddenField').val($('#debugSelectIngredient').val())
      $('#hiddenForm').submit()
  $('#randomAdd').click (e)->
    console.log(e)
    e.preventDefault()
    opt = $('#debugSelectIngredient option')
    v = opt.eq(Math.floor((opt.length-1) * Math.random())+1).val()
    $('#hiddenField').val(v)
    console.log(v)
    $('#hiddenForm').submit()
    

