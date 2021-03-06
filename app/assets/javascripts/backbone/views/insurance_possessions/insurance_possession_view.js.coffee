CertOrbe.Views.InsurancePossessions ||= {}

class CertOrbe.Views.InsurancePossessions.InsurancePossessionView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesInsurancePossessionsInsurancePossession").tmpl(data)

  tagName: "tr"

  events:
    _.extend( _.clone(@__super__.events),
     {}
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    return this
