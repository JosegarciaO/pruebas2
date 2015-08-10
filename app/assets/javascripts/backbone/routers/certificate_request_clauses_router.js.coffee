class CertOrbe.Routers.CertificateRequestClausesRouter extends CertOrbe.Routers.BaseRouter
  initialize: (options) ->
    @certificateRequestClauses = new CertOrbe.Collections.CertificateRequestClausesCollection()
    @certificateRequestClauses.reset options.certificateRequestClauses

  routes:
    "/new"      : "newCertificateRequestClause"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newCertificateRequestClause: ->
    @newCertificateRequestClauseView = new CertOrbe.Views.CertificateRequestClauses.NewView(collection: @certificateRequestClauses)
    $("#certificate_request_clauses").html(@newCertificateRequestClauseView.render().el)

  index: ->
    @indexView = new CertOrbe.Views.CertificateRequestClauses.IndexView(certificateRequestClauses: @certificateRequestClauses)
    $("#certificate_request_clauses").html(@indexView.render().el)

  show: (id) ->
    certificate_request_clause = @certificateRequestClauses.get(id)

    if certificate_request_clause?
      certificate_request_clause.setAllValues()

      @showView = new CertOrbe.Views.CertificateRequestClauses.ShowView(model: certificate_request_clause)
      $("#certificate_request_clauses").html(@showView.render().el)
    else @resourceNotFound()

  edit: (id) ->
    certificate_request_clause = @certificateRequestClauses.get(id)

    if certificate_request_clause?
      certificate_request_clause.setAllValues()

      @editView = new CertOrbe.Views.CertificateRequestClauses.EditView(model: certificate_request_clause)
      $("#certificate_request_clauses").html(@editView.render().el)
    else @resourceNotFound()
