CertOrbe.Views.CertificateRequests ||= {}

class CertOrbe.Views.CertificateRequests.CertificateRequestView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesCertificateRequestsCertificateRequest").tmpl(data)

  tagName: "tr"

  events:
    _.extend( _.clone(@__super__.events),
     {}
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    if @.model.get('cancelado')
    	$(@el).addClass('item_inactivo')
    return this
