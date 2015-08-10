CertOrbe.Views.CertificateRequestCoverages ||= {}

class CertOrbe.Views.CertificateRequestCoverages.EditView extends CertOrbe.Views.CertificateRequestCoverages.FormView
  template: (data) -> $("#backboneTemplatesCertificateRequestCoveragesEdit").tmpl(data)

  initialize: ->
    @model.bind("error", @renderErrors)
    @model.prepareToEdit()

  events:
    _.extend( _.clone(@__super__.events),
      "submit #edit_certificate_request_coverage" : "update"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#edit_certificate_request_coverage").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
