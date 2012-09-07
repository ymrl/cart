Cart.Views.Nutrition ||= {}

class Cart.Views.Nutrition.IndexView extends Backbone.View
  template: JST["backbone/templates/nutrition/index"]

  initialize: () ->
    @options.commodities.bind('reset', @render)
    @options.commodities.bind('add',@render)
    @options.commodities.bind('change',@render)
    @people = 4

  prepare: =>
    arr = []
    for i of @nutrition
      standard = Cart.Constants.Nutrition[i].standard * @people / 3
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
    $(@el).html(html)

    return this
