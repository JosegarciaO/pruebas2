CertOrbe.Views.Cities ||= {}

class CertOrbe.Views.Cities.NewView extends CertOrbe.Views.Cities.FormView
  template: (data) -> $("#backboneTemplatesCitiesNew").tmpl(data)

  initialize: (options) ->
    super(options)
    @model = new @collection.model()
    @model.bind("error", @renderErrors)

  events:
    _.extend( _.clone(@__super__.events),
      "submit #new_city": "save"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#new_city").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
