#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Cart =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  Constants:
    Nutrition:
      calorie:
        standard: 2100.0
        unit:     'kcal'
        name:     'カロリー'
      carbohydrates:
        standard: 320.0
        unit:     'g'
        name:     '炭水化物'
      protein:
        standard: 75.0
        unit:     'g'
        name:     'タンパク質'
      fat:
        standard: 55.0
        unit:     'g'
        name:     '脂質'
      carotene:
        standard: 45.0
        unit:     'μg'
        name:     'カロテン'
      vitamin_b1:
        standard: 1.0
        unit:     'mg'
        name:     'ビタミンB1'
      vitamin_b2:
        standard: 1.10
        unit:     'mg'
        name:     'ビタミンB2'
      vitamin_c:
        standard: 80.0
        unit:     'mg'
        name:     'ビタミンC'
      calcium:
        standard: 700.0
        unit:     'mg'
        name:     'カルシウム'
