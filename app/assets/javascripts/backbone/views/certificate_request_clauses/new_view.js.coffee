CertOrbe.Views.CertificateRequestClauses ||= {}

class CertOrbe.Views.CertificateRequestClauses.NewView extends CertOrbe.Views.CertificateRequestClauses.FormView
  template: (data) -> $("#backboneTemplatesCertificateRequestClausesNew").tmpl(data)

  initialize: (options) ->
    super(options)
    @model = new @collection.model()
    @model.bind("error", @renderErrors)

  events:
    _.extend( _.clone(@__super__.events),
      "submit #new_certificate_request_clause": "save"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#new_certificate_request_clause").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
