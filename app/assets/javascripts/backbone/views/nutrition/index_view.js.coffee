Cart.Views.Nutrition ||= {}

class Cart.Views.Nutrition.IndexView extends Backbone.View
  template: JST["backbone/templates/nutrition/index"]

  events:
    "change #times":"changeTimes"
    "change #people":"changePeople"
    "submit #configForm":"noEvent"
  noEvent: (e)=>
    e.preventDefault()
  changePeople: (e)=>
    e.preventDefault()
    @people = Math.max(1,+@$el.find('#people').val())
    @render()
  changeTimes: (e)=>
    e.preventDefault()
    @times = Math.max(1,+@$el.find('#times').val())
    @render()

  initialize: () ->
    @options.commodities.bind('reset', @render)
    @options.commodities.bind('add',@render)
    @options.commodities.bind('change',@render)
    @people = 4
    @times  = 1

  prepare: =>
    arr = []
    for i of @nutrition
      standard = Cart.Constants.Nutrition[i].standard * @times * @people / 3
      contain = @nutrition[i] / (standard)
      arr.push
        standard: standard
        contain:  contain
        nutrition: i
    return arr.sort((a,b)->a.contain - b.contain)
  render: =>
    @nutrition = @options.commodities.getNutrition()
    data = @prepare()
    advise = null
    title = null
    if @options.commodities.length == 0
      advise = Cart.Constants.Messages.start
      title = 'いらっしゃいませ'
    else if data[0].contain < 1
      advise = Cart.Constants.Messages[data[0].nutrition]
      lack = []
      for i in data
        if i.contain < 1
          lack.push(i)
        else
          break
      title = "#{lack.join('・')}が不足しています"
    else
      advise =  Cart.Constants.Messages.perfect
      title = "十分な栄養が取れそうです"

    html = @template
      nutrition: @nutrition
      constant: Cart.Constants.Nutrition
      data:     data
      people:   @people
      times:    @times
      advise:   advise
      title:    title
    $(@el).html(html)

    return this
