CertOrbe.Views.InsuranceCoverages ||= {}

class CertOrbe.Views.InsuranceCoverages.InsuranceCoverageView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesInsuranceCoveragesInsuranceCoverage").tmpl(data)

  tagName: "tr"

  events:
    _.extend( _.clone(@__super__.events),
     {}
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    return this
