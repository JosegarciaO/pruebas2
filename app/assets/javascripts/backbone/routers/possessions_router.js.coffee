class CertOrbe.Routers.PossessionsRouter extends CertOrbe.Routers.BaseRouter
  initialize: (options) ->
    @possessions = new CertOrbe.Collections.PossessionsCollection()
    @possessions.reset options.possessions

  routes:
    "/new"      : "newPossession"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newPossession: ->
    @newPossessionView = new CertOrbe.Views.Possessions.NewView(collection: @possessions)
    $("#possessions").html(@newPossessionView.render().el)

  index: ->
    @indexView = new CertOrbe.Views.Possessions.IndexView(possessions: @possessions)
    $("#possessions").html(@indexView.render().el)

  show: (id) ->
    possession = @possessions.get(id)

    if possession?
      possession.setAllValues()

      @showView = new CertOrbe.Views.Possessions.ShowView(model: possession)
      $("#possessions").html(@showView.render().el)
    else @resourceNotFound()

  edit: (id) ->
    possession = @possessions.get(id)

    if possession?
      possession.setAllValues()

      @editView = new CertOrbe.Views.Possessions.EditView(model: possession)
      $("#possessions").html(@editView.render().el)
    else @resourceNotFound()
