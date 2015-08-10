CertOrbe.Views.CertificateRequests ||= {}

class CertOrbe.Views.CertificateRequests.IndexView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesCertificateRequestsIndex").tmpl(data)

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.certificateRequests.bind('reset', @addAll)

  events:
    _.extend _.clone(@__super__.events),
      "click #refresh_certificate_requests" : "refreshCertificateRequests"
      "change #filter_status" : "changeFilterStatus"
      "change #search_text" : "searchText"

  refreshCertificateRequests: (e) ->
    e.preventDefault()
    this.filterCertificates()

  addAll: () ->
    @$("#certificate_requests_table tbody").empty()
    @renderPagination(@options.certificateRequests)
    @options.certificateRequests.each(@addOne)

  addOne: (certificateRequest) ->
    view = new CertOrbe.Views.CertificateRequests.CertificateRequestView({model : certificateRequest})
    @$("#certificate_requests_table tbody").append(view.render().el)

  render: ->
    template = @template(certificateRequests: @options.certificateRequests.toJSON(true, true) )
    $(@el).html template
    @addAll()

    return this

  remove: ->
    @options.certificateRequests.unbind('reset', @addAll)
    super()

  pagination: (e) ->
    super(e, @options.certificateRequests)

  setFiltersValues: () ->
    # these TMP fields are on the main INDEX template
    $("#filter_status").val( $("#tmp-value-status").val() )  if $("#tmp-value-status").val()
    $("#search_text").val( $("#tmp-value-search").val() )  if $("#tmp-value-search").val()

  changeFilterStatus: (e) ->
    e.preventDefault()
    $("#tmp-value-status").val(e.currentTarget.value)
    this.filterCertificates()

  searchText: (e) ->
    e.preventDefault()
    $("#tmp-value-search").val(e.currentTarget.value)
    this.filterCertificates()

  filterCertificates: () ->
    status = $("#filter_status").val() || 0
    search = $("#search_text").val()  || ''
    @options.certificateRequests.fetch({ data:{status:status, search:search} })
