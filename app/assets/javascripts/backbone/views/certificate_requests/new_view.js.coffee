CertOrbe.Views.CertificateRequests ||= {}

class CertOrbe.Views.CertificateRequests.NewView extends CertOrbe.Views.CertificateRequests.FormView
  template: (data) -> $("#backboneTemplatesCertificateRequestsNew").tmpl(data)
  itemTemplate: (data) -> $("#backboneTemplatesCertificateRequestsCertificateRequestCoverageFieldsForEdit").tmpl(data)

  initialize: (options) ->
    super(options)
    @model = new @collection.model()
    @model.bind("error", @renderErrors)
    @initClauses()
    @policies = new CertOrbe.Collections.PoliciesCollection()
    @policies.fetch()

  events:
    _.extend( _.clone(@__super__.events),
      "submit #new_certificate_request": "save"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    @fillDefaultStuff()  # -- inicializar los datos default
    this.$("form#new_certificate_request").backboneLink(@model)
    @$(".calendario").datepicker()
    return this

  fillDefaultStuff: () ->
    valor = $(@el).find("#certificate_request_packaging").val()
    @model.set({packaging: valor})

  selectCountryDefault: ->
    data = CertOrbe.Helpers.jsonData(
      'countries/getCountryDefault'
      {}
    )
    if data
      $("#country_id").val(data.id)
      $("#country_id").trigger('change')
      $("#country_from_id").val(data.id)
      $("#country_from_id").trigger('change')
      $("#country_to_id").val(data.id)
      $("#country_to_id").trigger('change')
