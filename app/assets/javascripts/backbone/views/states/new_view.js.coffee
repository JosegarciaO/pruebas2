CertOrbe.Views.States ||= {}

class CertOrbe.Views.States.NewView extends CertOrbe.Views.States.FormView
  template: (data) -> $("#backboneTemplatesStatesNew").tmpl(data)

  initialize: (options) ->
    super(options)
    @model = new @collection.model()
    @model.bind("error", @renderErrors)

  events:
    _.extend( _.clone(@__super__.events),
      "submit #new_state": "save"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#new_state").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
