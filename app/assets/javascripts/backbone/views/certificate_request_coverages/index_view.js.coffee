CertOrbe.Views.CertificateRequestCoverages ||= {}

class CertOrbe.Views.CertificateRequestCoverages.IndexView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesCertificateRequestCoveragesIndex").tmpl(data)

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.certificateRequestCoverages.bind('reset', @addAll)

  events:
    _.extend _.clone(@__super__.events),
      "click #refresh_certificate_request_coverages" : "refreshCertificateRequestCoverages"

  refreshCertificateRequestCoverages: (e) ->
    e.preventDefault()
    @options.certificateRequestCoverages.fetch()

  addAll: () ->
    @$("#certificate_request_coverages_table tbody").empty()
    @renderPagination(@options.certificateRequestCoverages)
    @options.certificateRequestCoverages.each(@addOne)

  addOne: (certificateRequestCoverage) ->
    view = new CertOrbe.Views.CertificateRequestCoverages.CertificateRequestCoverageView({model : certificateRequestCoverage})
    @$("#certificate_request_coverages_table tbody").append(view.render().el)

  render: ->
    template = @template(certificateRequestCoverages: @options.certificateRequestCoverages.toJSON(true, true) )
    $(@el).html template
    @addAll()

    return this

  remove: ->
    @options.certificateRequestCoverages.unbind('reset', @addAll)
    super()

  pagination: (e) ->
    super(e, @options.certificateRequestCoverages)
