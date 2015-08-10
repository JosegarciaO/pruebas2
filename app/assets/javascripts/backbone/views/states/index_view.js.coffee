CertOrbe.Views.States ||= {}

class CertOrbe.Views.States.IndexView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesStatesIndex").tmpl(data)

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.states.bind('reset', @addAll)

  events:
    _.extend _.clone(@__super__.events),
      "click #refresh_states" : "refreshStates"

  refreshStates: (e) ->
    e.preventDefault()
    @options.states.fetch()

  addAll: () ->
    @$("#states_table tbody").empty()
    @renderPagination(@options.states)
    @options.states.each(@addOne)

  addOne: (state) ->
    view = new CertOrbe.Views.States.StateView({model : state})
    @$("#states_table tbody").append(view.render().el)

  render: ->
    template = @template(states: @options.states.toJSON(true, true) )
    $(@el).html template
    @addAll()

    return this

  remove: ->
    @options.states.unbind('reset', @addAll)
    super()

  pagination: (e) ->
    super(e, @options.states)
