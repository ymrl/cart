Cart.Views.Commodities ||= {}

class Cart.Views.Commodities.EditView extends Backbone.View
  template : JST["backbone/templates/commodities/edit"]

  events :
    "submit #edit-commodity" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (commodity) =>
        @model = commodity
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
