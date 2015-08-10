CertOrbe.Views.CertificateRequests ||= {}

class CertOrbe.Views.CertificateRequests.ShowView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesCertificateRequestsShow").tmpl(data)

  events:
    _.extend( _.clone(@__super__.events),
      {}
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    return this

  destroy: (e) ->
    super(e, success: () -> window.location.hash = "")

  remove: ->
    super()
