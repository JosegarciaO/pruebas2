class CertOrbe.Routers.TransportationsRouter extends CertOrbe.Routers.BaseRouter
  initialize: (options) ->
    @transportations = new CertOrbe.Collections.TransportationsCollection()
    @transportations.reset options.transportations

  routes:
    "/new"      : "newTransportation"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newTransportation: ->
    @newTransportationView = new CertOrbe.Views.Transportations.NewView(collection: @transportations)
    $("#transportations").html(@newTransportationView.render().el)

  index: ->
    @indexView = new CertOrbe.Views.Transportations.IndexView(transportations: @transportations)
    $("#transportations").html(@indexView.render().el)

  show: (id) ->
    transportation = @transportations.get(id)

    if transportation?
      transportation.setAllValues()

      @showView = new CertOrbe.Views.Transportations.ShowView(model: transportation)
      $("#transportations").html(@showView.render().el)
    else @resourceNotFound()

  edit: (id) ->
    transportation = @transportations.get(id)

    if transportation?
      transportation.setAllValues()

      @editView = new CertOrbe.Views.Transportations.EditView(model: transportation)
      $("#transportations").html(@editView.render().el)
    else @resourceNotFound()
