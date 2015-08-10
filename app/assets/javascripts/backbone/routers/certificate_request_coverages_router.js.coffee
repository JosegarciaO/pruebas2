class CertOrbe.Routers.CertificateRequestCoveragesRouter extends CertOrbe.Routers.BaseRouter
  initialize: (options) ->
    @certificateRequestCoverages = new CertOrbe.Collections.CertificateRequestCoveragesCollection()
    @certificateRequestCoverages.reset options.certificateRequestCoverages

  routes:
    "/new"      : "newCertificateRequestCoverage"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newCertificateRequestCoverage: ->
    @newCertificateRequestCoverageView = new CertOrbe.Views.CertificateRequestCoverages.NewView(collection: @certificateRequestCoverages)
    $("#certificate_request_coverages").html(@newCertificateRequestCoverageView.render().el)

  index: ->
    @indexView = new CertOrbe.Views.CertificateRequestCoverages.IndexView(certificateRequestCoverages: @certificateRequestCoverages)
    $("#certificate_request_coverages").html(@indexView.render().el)

  show: (id) ->
    certificate_request_coverage = @certificateRequestCoverages.get(id)

    if certificate_request_coverage?
      certificate_request_coverage.setAllValues()

      @showView = new CertOrbe.Views.CertificateRequestCoverages.ShowView(model: certificate_request_coverage)
      $("#certificate_request_coverages").html(@showView.render().el)
    else @resourceNotFound()

  edit: (id) ->
    certificate_request_coverage = @certificateRequestCoverages.get(id)

    if certificate_request_coverage?
      certificate_request_coverage.setAllValues()

      @editView = new CertOrbe.Views.CertificateRequestCoverages.EditView(model: certificate_request_coverage)
      $("#certificate_request_coverages").html(@editView.render().el)
    else @resourceNotFound()
