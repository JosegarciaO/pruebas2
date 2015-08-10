CertOrbe.Views.PossessionDescriptions ||= {}

class CertOrbe.Views.PossessionDescriptions.EditView extends CertOrbe.Views.PossessionDescriptions.FormView
  template: (data) -> $("#backboneTemplatesPossessionDescriptionsEdit").tmpl(data)

  initialize: ->
    @model.bind("error", @renderErrors)
    @model.prepareToEdit()

  events:
    _.extend( _.clone(@__super__.events),
      "submit #edit_possession_description" : "update"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#edit_possession_description").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
