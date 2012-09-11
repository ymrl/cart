Cart.Views.Nutrition ||= {}

class Cart.Views.Nutrition.IndexView extends Backbone.View
  template: JST["backbone/templates/nutrition/index"]

  events:
    "change #times":"changeTimes"
    "change #people":"changePeople"
    "submit #configForm":"noEvent"
    "click .peopleInclement" : "peopleInclement"
    "click .peopleDeclement" : "peopleDeclement"
    "click .timesInclement"  : "timesInclement"
    "click .timesDeclement"  : "timesDeclement"

  peopleInclement:(e)=>
    e.preventDefault()
    @people += 1
    @render()
  peopleDeclement:(e)=>
    e.preventDefault()
    @people = Math.max(@people-1,1)
    @render()
  timesInclement:(e)=>
    e.preventDefault()
    @times += 1
    @render()
  timesDeclement:(e)=>
    e.preventDefault()
    @times = Math.max(@times-1,1)
    @render()
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
    @suggestionView = new Cart.Views.Nutrition.SuggestionView

  prepare: =>
    arr = []
    for i of @nutrition
      standard = Cart.Constants.Nutrition[i].standard * @times * @people / 3
      contain = @nutrition[i] / (standard)
      arr.push
        standard: standard
        contain:  contain
        nutrition: i
    @sorted = arr.sort((a,b)->a.contain - b.contain)
  render: =>
    @nutrition = @options.commodities.getNutrition()
    data = @prepare()
    advise = null
    title = null
    if @options.commodities.length == 0
      advise = Cart.Constants.Messages.start
      title = 'いらっしゃいませ'
      @suggestionView.getData('start')
    else if data[0].contain < 1
      advise = Cart.Constants.Messages[data[0].nutrition]
      @suggestionView.getData(data[0].nutrition)
      lack = []
      for i in data
        if i.contain < 1
          lack.push(Cart.Constants.Nutrition[i.nutrition].name)
        else
          break
      title = "#{lack.join('・')}が不足しています"
    else
      advise =  Cart.Constants.Messages.perfect
      title = "十分な栄養が取れそうです"
      @suggestionView.getData('perfect')

    html = @template
      nutrition: @nutrition
      constant: Cart.Constants.Nutrition
      data:     data
      people:   @people
      times:    @times
      advise:   advise
      title:    title
    $(@el).html(html)
    @$el.find('.summarizedView').html(@suggestionView.render().el)
    @scorll = new iScroll(@$el.find('.advise').get(0))

    return this
