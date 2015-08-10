CertOrbe.Views.CertificateRequestCoverages ||= {}

class CertOrbe.Views.CertificateRequestCoverages.NewView extends CertOrbe.Views.CertificateRequestCoverages.FormView
  template: (data) -> $("#backboneTemplatesCertificateRequestCoveragesNew").tmpl(data)

  initialize: (options) ->
    super(options)
    @model = new @collection.model()
    @model.bind("error", @renderErrors)

  events:
    _.extend( _.clone(@__super__.events),
      "submit #new_certificate_request_coverage": "save"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#new_certificate_request_coverage").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
