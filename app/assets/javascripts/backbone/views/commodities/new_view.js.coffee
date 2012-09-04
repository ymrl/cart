Cart.Views.Commodities ||= {}

class Cart.Views.Commodities.NewView extends Backbone.View
  template: JST["backbone/templates/commodities/new"]

  events:
    "submit #new-commodity": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (commodity) =>
        @model = commodity
        window.location.hash = "/#{@model.id}"

      error: (commodity, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
