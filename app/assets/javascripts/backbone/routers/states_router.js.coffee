class CertOrbe.Routers.StatesRouter extends CertOrbe.Routers.BaseRouter
  initialize: (options) ->
    @states = new CertOrbe.Collections.StatesCollection()
    @states.reset options.states

  routes:
    "/new"      : "newState"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newState: ->
    @newStateView = new CertOrbe.Views.States.NewView(collection: @states)
    $("#states").html(@newStateView.render().el)

  index: ->
    @indexView = new CertOrbe.Views.States.IndexView(states: @states)
    $("#states").html(@indexView.render().el)

  show: (id) ->
    state = @states.get(id)

    if state?
      state.setAllValues()

      @showView = new CertOrbe.Views.States.ShowView(model: state)
      $("#states").html(@showView.render().el)
    else @resourceNotFound()

  edit: (id) ->
    state = @states.get(id)

    if state?
      state.setAllValues()

      @editView = new CertOrbe.Views.States.EditView(model: state)
      $("#states").html(@editView.render().el)
    else @resourceNotFound()
