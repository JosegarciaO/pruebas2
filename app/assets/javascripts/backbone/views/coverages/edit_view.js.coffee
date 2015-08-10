CertOrbe.Views.Coverages ||= {}

class CertOrbe.Views.Coverages.EditView extends CertOrbe.Views.Coverages.FormView
  template: (data) -> $("#backboneTemplatesCoveragesEdit").tmpl(data)

  initialize: ->
    @model.bind("error", @renderErrors)
    @model.prepareToEdit()

  events:
    _.extend( _.clone(@__super__.events),
      "submit #edit_coverage" : "update"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#edit_coverage").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
