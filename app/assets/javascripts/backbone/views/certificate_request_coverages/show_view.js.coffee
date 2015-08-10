CertOrbe.Views.CertificateRequestCoverages ||= {}

class CertOrbe.Views.CertificateRequestCoverages.ShowView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesCertificateRequestCoveragesShow").tmpl(data)

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
