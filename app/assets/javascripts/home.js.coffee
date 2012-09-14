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

  debug.commodities = commodities
  debug.commoditiesView = commoditiesView

  readJan = (jan,commodityCount)->
    #if a = commodities.findByJan(jan)
    #  if commodityCount
    #    a.set('count',commodityCount)
    #    return a

    commodities.addJan jan,(collection,data)->
      if commodityCount
        collection.get(data.id).set('count',commodityCount)
      collection.get(data.id).searchRecipes (collection,data)->
        for recipe in collection.models
          exist = recipes.get(recipe.id)
          if exist
            exist.set('count',exist.get('count') + 1)
          else
            recipes.add(recipe)
        recipes.trigger('changeAndRemove')

      collection.get(data.id).bind 'remove',(commodity,collection,data)->
        for recipe in commodity.recipes.models
          exist = recipes.get(recipe.id)
          if exist
            count = exist.get('count')
            if(count > 1)
              exist.set('count',count - 1)
            else
              recipes.remove(exist)
        recipes.trigger('changeAndRemove')

  oldItems = JSON.parse(localStorage.getItem('commodities'))

  if oldItems
    for i in oldItems
      readJan(i.jan,i.count)

  saveToLocalStorage = ()->
    #a = []
    #for commodity in commodities.models
    #  i = 0
    #  count = commodity.get('count')
    #  jan = commodity.get('jan')
    #  while i < count
    #    a.push jan
    #    i++
    #console.log(a)
    #localStorage.setItem('commodities',JSON.stringify(a))
    #localStorage.setItem('commodities',JSON.stringify(commodities.models.map((e)->e.get('jan'))))
    localStorage.setItem('commodities',JSON.stringify(commodities.toJSON()))

  commodities.bind 'add',(commodity,collection)->
    saveToLocalStorage()
    #localStorage.setItem('commodities',JSON.stringify(collection.models.map((e)->e.get('jan'))))

  commodities.bind 'remove',(commodity,collection)->
    saveToLocalStorage()
    #localStorage.setItem('commodities',JSON.stringify(collection.models.map((e)->e.get('jan'))))
    #
  commodities.bind 'change',(commodity,collection)->
    saveToLocalStorage()
    #localStorage.setItem('commodities',JSON.stringify(collection.models.map((e)->e.get('jan'))))


  nutritionView = new Cart.Views.Nutrition.IndexView
    commodities: commodities
  $('#nutrition').append(nutritionView.render().el)

  $('#hiddenForm').submit (e)->
    e.preventDefault()
    $('#content').addClass('attention')
    setTimeout (->$('#content').removeClass 'attention'),1
    readJan($('#hiddenField').val())
    $('#hiddenField').val('')

  
  touching = null
  if navigator.userAgent.match(/iPad/)
    $('#content .containerInner').bind 'touchstart',(e)->
      target = $(this)
      touching = target.attr('id')
      $('#hiddenField').focus()
    $('.containerInner').bind 'touchend',(e)->
      target = $(this)
      id = target.attr('id')
      if id is touching
        if !target.hasClass('open')
          $('.open').removeClass('open')
          target.addClass('open')
      touching = null
      $('#hiddenField').focus()
    $('#content').bind 'touchend',(e)->
      $('#hiddenField').focus()
    $('#content').bind 'touchstart',(e)->
      $('#hiddenField').focus()
  else
    $('#content .containerInner').bind 'click',(e)->
      t = $(@)
      if !t.hasClass('open')
        $('.open').removeClass('open')
        t.addClass('open')
    $('#content').click (e)->
      $('#hiddenField').focus()

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
    e.preventDefault()
    opt = $('#debugSelectIngredient option')
    v = opt.eq(Math.floor((opt.length-1) * Math.random())+1).val()
    $('#hiddenField').val(v)
    $('#hiddenForm').submit()
  $('div').live('click',(e)->$('#hiddenField').focus())
  $('body').bind 'touchstart',(e)->$('#hiddenField').focus();e.preventDefault()
  $('body').bind 'touchmove' ,(e)->$('#hiddenField').focus();e.preventDefault()
  $('body').bind 'touchend'  ,(e)->$('#hiddenField').focus();e.preventDefault()
