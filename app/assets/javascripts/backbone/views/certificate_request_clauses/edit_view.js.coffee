CertOrbe.Views.CertificateRequestClauses ||= {}

class CertOrbe.Views.CertificateRequestClauses.EditView extends CertOrbe.Views.CertificateRequestClauses.FormView
  template: (data) -> $("#backboneTemplatesCertificateRequestClausesEdit").tmpl(data)

  initialize: ->
    @model.bind("error", @renderErrors)
    @model.prepareToEdit()

  events:
    _.extend( _.clone(@__super__.events),
      "submit #edit_certificate_request_clause" : "update"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#edit_certificate_request_clause").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
