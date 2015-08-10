CertOrbe.Views.CertificateRequestClauses ||= {}

class CertOrbe.Views.CertificateRequestClauses.IndexView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesCertificateRequestClausesIndex").tmpl(data)

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.certificateRequestClauses.bind('reset', @addAll)

  events:
    _.extend _.clone(@__super__.events),
      "click #refresh_certificate_request_clauses" : "refreshCertificateRequestClauses"

  refreshCertificateRequestClauses: (e) ->
    e.preventDefault()
    @options.certificateRequestClauses.fetch()

  addAll: () ->
    @$("#certificate_request_clauses_table tbody").empty()
    @renderPagination(@options.certificateRequestClauses)
    @options.certificateRequestClauses.each(@addOne)

  addOne: (certificateRequestClause) ->
    view = new CertOrbe.Views.CertificateRequestClauses.CertificateRequestClauseView({model : certificateRequestClause})
    @$("#certificate_request_clauses_table tbody").append(view.render().el)

  render: ->
    template = @template(certificateRequestClauses: @options.certificateRequestClauses.toJSON(true, true) )
    $(@el).html template
    @addAll()

    return this

  remove: ->
    @options.certificateRequestClauses.unbind('reset', @addAll)
    super()

  pagination: (e) ->
    super(e, @options.certificateRequestClauses)
