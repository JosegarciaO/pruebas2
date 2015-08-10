CertOrbe.Views.InsuranceCoverages ||= {}

class CertOrbe.Views.InsuranceCoverages.EditView extends CertOrbe.Views.InsuranceCoverages.FormView
  template: (data) -> $("#backboneTemplatesInsuranceCoveragesEdit").tmpl(data)

  initialize: ->
    @model.bind("error", @renderErrors)
    @model.prepareToEdit()

  events:
    _.extend( _.clone(@__super__.events),
      "submit #edit_insurance_coverage" : "update"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#edit_insurance_coverage").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
