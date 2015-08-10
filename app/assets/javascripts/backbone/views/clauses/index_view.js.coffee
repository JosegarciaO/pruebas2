CertOrbe.Views.Clauses ||= {}

class CertOrbe.Views.Clauses.IndexView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesClausesIndex").tmpl(data)

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.clauses.bind('reset', @addAll)

  events:
    _.extend _.clone(@__super__.events),
      "click #refresh_clauses" : "refreshClauses"

  refreshClauses: (e) ->
    e.preventDefault()
    @options.clauses.fetch()

  addAll: () ->
    @$("#clauses_table tbody").empty()
    @renderPagination(@options.clauses)
    @options.clauses.each(@addOne)

  addOne: (clause) ->
    view = new CertOrbe.Views.Clauses.ClauseView({model : clause})
    @$("#clauses_table tbody").append(view.render().el)

  render: ->
    template = @template(clauses: @options.clauses.toJSON(true, true) )
    $(@el).html template
    @addAll()

    return this

  remove: ->
    @options.clauses.unbind('reset', @addAll)
    super()

  pagination: (e) ->
    super(e, @options.clauses)
