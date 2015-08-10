CertOrbe.Views.CertificateRequestCoverages ||= {}

class CertOrbe.Views.CertificateRequestCoverages.CertificateRequestCoverageView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesCertificateRequestCoveragesCertificateRequestCoverage").tmpl(data)

  tagName: "tr"

  events:
    _.extend( _.clone(@__super__.events),
     {}
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    return this
