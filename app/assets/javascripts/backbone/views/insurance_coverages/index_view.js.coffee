CertOrbe.Views.InsuranceCoverages ||= {}

class CertOrbe.Views.InsuranceCoverages.IndexView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesInsuranceCoveragesIndex").tmpl(data)

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.insuranceCoverages.bind('reset', @addAll)

  events:
    _.extend _.clone(@__super__.events),
      "click #refresh_insurance_coverages" : "refreshInsuranceCoverages"

  refreshInsuranceCoverages: (e) ->
    e.preventDefault()
    @options.insuranceCoverages.fetch()

  addAll: () ->
    @$("#insurance_coverages_table tbody").empty()
    @renderPagination(@options.insuranceCoverages)
    @options.insuranceCoverages.each(@addOne)

  addOne: (insuranceCoverage) ->
    view = new CertOrbe.Views.InsuranceCoverages.InsuranceCoverageView({model : insuranceCoverage})
    @$("#insurance_coverages_table tbody").append(view.render().el)

  render: ->
    template = @template(insuranceCoverages: @options.insuranceCoverages.toJSON(true, true) )
    $(@el).html template
    @addAll()

    return this

  remove: ->
    @options.insuranceCoverages.unbind('reset', @addAll)
    super()

  pagination: (e) ->
    super(e, @options.insuranceCoverages)
