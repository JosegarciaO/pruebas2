CertOrbe.Views.CertificateRequestClauses ||= {}

class CertOrbe.Views.CertificateRequestClauses.CertificateRequestClauseView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesCertificateRequestClausesCertificateRequestClause").tmpl(data)

  tagName: "tr"

  events:
    _.extend( _.clone(@__super__.events),
     {}
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    return this
