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
    html = @template
      nutrition: @nutrition
      constant: Cart.Constants.Nutrition
      data:     data
      people:   @people
      times:    @times
    $(@el).html(html)

    return this
