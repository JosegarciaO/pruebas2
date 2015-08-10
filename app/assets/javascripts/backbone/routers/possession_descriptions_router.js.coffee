class CertOrbe.Routers.PossessionDescriptionsRouter extends CertOrbe.Routers.BaseRouter
  initialize: (options) ->
    @possessionDescriptions = new CertOrbe.Collections.PossessionDescriptionsCollection()
    @possessionDescriptions.reset options.possessionDescriptions

  routes:
    "/new"      : "newPossessionDescription"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newPossessionDescription: ->
    @newPossessionDescriptionView = new CertOrbe.Views.PossessionDescriptions.NewView(collection: @possessionDescriptions)
    $("#possession_descriptions").html(@newPossessionDescriptionView.render().el)

  index: ->
    @indexView = new CertOrbe.Views.PossessionDescriptions.IndexView(possessionDescriptions: @possessionDescriptions)
    $("#possession_descriptions").html(@indexView.render().el)

  show: (id) ->
    possession_description = @possessionDescriptions.get(id)

    if possession_description?
      possession_description.setAllValues()

      @showView = new CertOrbe.Views.PossessionDescriptions.ShowView(model: possession_description)
      $("#possession_descriptions").html(@showView.render().el)
    else @resourceNotFound()

  edit: (id) ->
    possession_description = @possessionDescriptions.get(id)

    if possession_description?
      possession_description.setAllValues()

      @editView = new CertOrbe.Views.PossessionDescriptions.EditView(model: possession_description)
      $("#possession_descriptions").html(@editView.render().el)
    else @resourceNotFound()
