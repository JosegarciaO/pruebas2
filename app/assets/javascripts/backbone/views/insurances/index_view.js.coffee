CertOrbe.Views.Insurances ||= {}

class CertOrbe.Views.Insurances.IndexView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesInsurancesIndex").tmpl(data)

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.insurances.bind('reset', @addAll)

  events:
    _.extend _.clone(@__super__.events),
      "click #refresh_insurances" : "refreshInsurances"

  refreshInsurances: (e) ->
    e.preventDefault()
    @options.insurances.fetch()

  addAll: () ->
    @$("#insurances_table tbody").empty()
    @renderPagination(@options.insurances)
    @options.insurances.each(@addOne)

  addOne: (insurance) ->
    view = new CertOrbe.Views.Insurances.InsuranceView({model : insurance})
    @$("#insurances_table tbody").append(view.render().el)

  render: ->
    template = @template(insurances: @options.insurances.toJSON(true, true) )
    $(@el).html template
    @addAll()

    return this

  remove: ->
    @options.insurances.unbind('reset', @addAll)
    super()

  pagination: (e) ->
    super(e, @options.insurances)
