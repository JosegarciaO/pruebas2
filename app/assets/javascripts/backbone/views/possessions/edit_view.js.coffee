CertOrbe.Views.Possessions ||= {}

class CertOrbe.Views.Possessions.EditView extends CertOrbe.Views.Possessions.FormView
  template: (data) -> $("#backboneTemplatesPossessionsEdit").tmpl(data)

  initialize: ->
    @model.bind("error", @renderErrors)
    @model.prepareToEdit()

  events:
    _.extend( _.clone(@__super__.events),
      "submit #edit_possession" : "update"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#edit_possession").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
