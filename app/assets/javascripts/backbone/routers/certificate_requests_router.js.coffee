class CertOrbe.Routers.CertificateRequestsRouter extends CertOrbe.Routers.BaseRouter
  initialize: (options) ->
    @certificateRequests = new CertOrbe.Collections.CertificateRequestsCollection()
    @certificateRequests.reset options.certificateRequests

  routes:
    "/new"      : "newCertificateRequest"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newCertificateRequest: ->
    @newCertificateRequestView = new CertOrbe.Views.CertificateRequests.NewView(collection: @certificateRequests)
    $("#certificate_requests").html(@newCertificateRequestView.render().el)
    @newCertificateRequestView.selectCountryDefault()  # Seleccionar pais MEXICO

  index: ->
    @indexView = new CertOrbe.Views.CertificateRequests.IndexView(certificateRequests: @certificateRequests)
    $("#certificate_requests").html(@indexView.render().el)
    @indexView.setFiltersValues()
    $("#refresh_certificate_requests").trigger('click')

  show: (id) ->
    certificate_request = @certificateRequests.get(id)

    if certificate_request?
      certificate_request.setAllValues()

      @showView = new CertOrbe.Views.CertificateRequests.ShowView(model: certificate_request)
      $("#certificate_requests").html(@showView.render().el)
    else @resourceNotFound()

  edit: (id) ->
    certificate_request = @certificateRequests.get(id)

    if certificate_request?
      certificate_request.setAllValues()

      @editView = new CertOrbe.Views.CertificateRequests.EditView(model: certificate_request)
      $("#certificate_requests").html(@editView.render().el)
      @editView.fillSelects()  # Carga los selects dependientes
      # $("#certificate_request_moneda").trigger('change')
      @editView.changeMoneda()
      
    else @resourceNotFound()
