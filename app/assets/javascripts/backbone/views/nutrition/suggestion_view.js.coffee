Cart.Views.Nutrition ||= {}

class Cart.Views.Nutrition.SuggestionView extends Backbone.View
  template: JST["backbone/templates/nutrition/suggestion"]
  initialize:()->
    @commodities = new Cart.Collections.CommoditiesCollection
    @commodities.bind('reset',@render)
    @commodities.bind('add',@render)
    @type = 'start'
  getData: (type)=>
    @type = type
    if type is 'perfect' or type is 'start'
      @commodities.searchPopular()
    else
      @commodities.searchNutrition type
  render:()=>
    @$el.html(@template(commodities:@commodities.toJSON()))
    if @type == 'start' or @type == 'perfect'
      @$el.find('h2').text('本日のおすすめ')
    else
      @$el.find('h2').text('あなたへのおすすめ')

      
    return @

