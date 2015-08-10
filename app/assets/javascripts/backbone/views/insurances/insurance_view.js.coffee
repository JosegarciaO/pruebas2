CertOrbe.Views.Insurances ||= {}

class CertOrbe.Views.Insurances.InsuranceView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesInsurancesInsurance").tmpl(data)

  tagName: "tr"

  events:
    _.extend( _.clone(@__super__.events),
     {}
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    return this
