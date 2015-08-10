CertOrbe.Views.CertificateRequestClauses ||= {}

class CertOrbe.Views.CertificateRequestClauses.ShowView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesCertificateRequestClausesShow").tmpl(data)

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
