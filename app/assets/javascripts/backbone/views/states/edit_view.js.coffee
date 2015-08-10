CertOrbe.Views.States ||= {}

class CertOrbe.Views.States.EditView extends CertOrbe.Views.States.FormView
  template: (data) -> $("#backboneTemplatesStatesEdit").tmpl(data)

  initialize: ->
    @model.bind("error", @renderErrors)
    @model.prepareToEdit()

  events:
    _.extend( _.clone(@__super__.events),
      "submit #edit_state" : "update"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#edit_state").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
