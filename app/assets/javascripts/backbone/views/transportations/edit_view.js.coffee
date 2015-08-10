CertOrbe.Views.Transportations ||= {}

class CertOrbe.Views.Transportations.EditView extends CertOrbe.Views.Transportations.FormView
  template: (data) -> $("#backboneTemplatesTransportationsEdit").tmpl(data)

  initialize: ->
    @model.bind("error", @renderErrors)
    @model.prepareToEdit()
    @initClausesList()

  events:
    _.extend( _.clone(@__super__.events),
      "submit #edit_transportation" : "update"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#edit_transportation").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
