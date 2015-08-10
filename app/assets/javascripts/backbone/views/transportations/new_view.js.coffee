CertOrbe.Views.Transportations ||= {}

class CertOrbe.Views.Transportations.NewView extends CertOrbe.Views.Transportations.FormView
  template: (data) -> $("#backboneTemplatesTransportationsNew").tmpl(data)

  initialize: (options) ->
    super(options)
    @model = new @collection.model()
    @model.bind("error", @renderErrors)
    @initClausesList()

  events:
    _.extend( _.clone(@__super__.events),
      "submit #new_transportation": "save"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#new_transportation").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
