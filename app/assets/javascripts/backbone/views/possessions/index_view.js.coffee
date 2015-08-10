CertOrbe.Views.Possessions ||= {}

class CertOrbe.Views.Possessions.IndexView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesPossessionsIndex").tmpl(data)

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.possessions.bind('reset', @addAll)

  events:
    _.extend _.clone(@__super__.events),
      "click #refresh_possessions" : "refreshPossessions"

  refreshPossessions: (e) ->
    e.preventDefault()
    @options.possessions.fetch()

  addAll: () ->
    @$("#possessions_table tbody").empty()
    @renderPagination(@options.possessions)
    @options.possessions.each(@addOne)

  addOne: (possession) ->
    view = new CertOrbe.Views.Possessions.PossessionView({model : possession})
    @$("#possessions_table tbody").append(view.render().el)

  render: ->
    template = @template(possessions: @options.possessions.toJSON(true, true) )
    $(@el).html template
    @addAll()

    return this

  remove: ->
    @options.possessions.unbind('reset', @addAll)
    super()

  pagination: (e) ->
    super(e, @options.possessions)
