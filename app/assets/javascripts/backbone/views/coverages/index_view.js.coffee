CertOrbe.Views.Coverages ||= {}

class CertOrbe.Views.Coverages.IndexView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesCoveragesIndex").tmpl(data)

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.coverages.bind('reset', @addAll)

  events:
    _.extend _.clone(@__super__.events),
      "click #refresh_coverages" : "refreshCoverages"

  refreshCoverages: (e) ->
    e.preventDefault()
    @options.coverages.fetch()

  addAll: () ->
    @$("#coverages_table tbody").empty()
    @renderPagination(@options.coverages)
    @options.coverages.each(@addOne)

  addOne: (coverage) ->
    view = new CertOrbe.Views.Coverages.CoverageView({model : coverage})
    @$("#coverages_table tbody").append(view.render().el)

  render: ->
    template = @template(coverages: @options.coverages.toJSON(true, true) )
    $(@el).html template
    @addAll()

    return this

  remove: ->
    @options.coverages.unbind('reset', @addAll)
    super()

  pagination: (e) ->
    super(e, @options.coverages)
