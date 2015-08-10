CertOrbe.Views.InsurancePossessions ||= {}

class CertOrbe.Views.InsurancePossessions.IndexView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesInsurancePossessionsIndex").tmpl(data)

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.insurancePossessions.bind('reset', @addAll)

  events:
    _.extend _.clone(@__super__.events),
      "click #refresh_insurance_possessions" : "refreshInsurancePossessions"

  refreshInsurancePossessions: (e) ->
    e.preventDefault()
    @options.insurancePossessions.fetch()

  addAll: () ->
    @$("#insurance_possessions_table tbody").empty()
    @renderPagination(@options.insurancePossessions)
    @options.insurancePossessions.each(@addOne)

  addOne: (insurancePossession) ->
    view = new CertOrbe.Views.InsurancePossessions.InsurancePossessionView({model : insurancePossession})
    @$("#insurance_possessions_table tbody").append(view.render().el)

  render: ->
    template = @template(insurancePossessions: @options.insurancePossessions.toJSON(true, true) )
    $(@el).html template
    @addAll()

    return this

  remove: ->
    @options.insurancePossessions.unbind('reset', @addAll)
    super()

  pagination: (e) ->
    super(e, @options.insurancePossessions)
