CertOrbe.Views.CertificateRequests ||= {}

class CertOrbe.Views.CertificateRequests.EditView extends CertOrbe.Views.CertificateRequests.FormView
  template: (data) -> $("#backboneTemplatesCertificateRequestsEdit").tmpl(data)
  itemTemplate: (data) -> $("#backboneTemplatesCertificateRequestsCertificateRequestCoverageFieldsForEdit").tmpl(data)

  initialize: ->
    view = @
    @model.bind("error", @renderErrors)
    @model.prepareToEdit()
    @initClauses()
    @policies = new CertOrbe.Collections.PoliciesCollection()
    @policies.fetch(
      success: (data) ->
        view.initCoberturas(data)
    )

  events:
    _.extend( _.clone(@__super__.events),
      "submit #edit_certificate_request" : "update"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    # - asignar el texto de deducibles por default
    valor = $(@el).find("#certificate_request_deducibles").val()
    @model.set({deducibles: valor})

    this.$("form#edit_certificate_request").backboneLink(@model)
    # - calendario
    @$(".calendario").datepicker()
    return this

  fillSelects: ->
    @fillOneSelect("#country_id",      "#state_id",      "countries/@/states", @model.get('country_id'))
    @fillOneSelect("#country_from_id", "#state_from_id", "countries/@/states", @model.get('country_from_id'))
    @fillOneSelect("#country_to_id",   "#state_to_id",   "countries/@/states", @model.get('country_to_id'))
    @fillOneSelect("#state_id",        "#certificate_request_city_id",      "states/@/cities", @model.get('state_id'))
    @fillOneSelect("#state_from_id",   "#certificate_request_city_from_id", "states/@/cities", @model.get('state_from_id'))
    @fillOneSelect("#state_to_id",     "#certificate_request_city_to_id",   "states/@/cities", @model.get('state_to_id'))

  fillOneSelect: (parent, child, url, model_attr) ->
    if $(child).length > 0
      $(child).html('')
      select = $(parent)
      url    = url.replace("@",model_attr)

      @fill_select({
        url:  url
        target: child
        select: select
        model: @model
      },false)

  changeMoneda: (e) ->
    id_poliza = null
    if @.model.get("id")   # si entro a editar
      id_poliza = @.model.get("policy_id") || null  # obtiene el valor inicial de Poliza

    data = CertOrbe.Helpers.jsonData(
      "policies/getPoliciesByCurrency",
      { id_moneda: @model.get('moneda'), id_poliza: id_poliza }
    )
    if $("#certificate_request_policy_id").length > 0
      $("#certificate_request_policy_id").html('<option value="">- Seleccione -</option>')
      if data and $.isArray(data)
        for item in data
          if id_poliza and id_poliza == item.id
            $("#certificate_request_policy_id").append('<option value="' + item.id + '" selected="selected">' + item.folio + '</option>')
          else
            $("#certificate_request_policy_id").append('<option value="' + item.id + '">' + item.folio + '</option>')
      @calcularImportes()
