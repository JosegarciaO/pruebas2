CertOrbe.Views.InsurancePossessions ||= {}

class CertOrbe.Views.InsurancePossessions.EditView extends CertOrbe.Views.InsurancePossessions.FormView
  template: (data) -> $("#backboneTemplatesInsurancePossessionsEdit").tmpl(data)

  initialize: ->
    @model.bind("error", @renderErrors)
    @model.prepareToEdit()

  events:
    _.extend( _.clone(@__super__.events),
      "submit #edit_insurance_possession" : "update"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#edit_insurance_possession").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
