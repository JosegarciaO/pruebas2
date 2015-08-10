class CertOrbe.Routers.PackagingsRouter extends CertOrbe.Routers.BaseRouter
  initialize: (options) ->
    @packagings = new CertOrbe.Collections.PackagingsCollection()
    @packagings.reset options.packagings

  routes:
    "/new"      : "newPackaging"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newPackaging: ->
    @newPackagingView = new CertOrbe.Views.Packagings.NewView(collection: @packagings)
    $("#packagings").html(@newPackagingView.render().el)

  index: ->
    @indexView = new CertOrbe.Views.Packagings.IndexView(packagings: @packagings)
    $("#packagings").html(@indexView.render().el)

  show: (id) ->
    packaging = @packagings.get(id)

    if packaging?
      packaging.setAllValues()

      @showView = new CertOrbe.Views.Packagings.ShowView(model: packaging)
      $("#packagings").html(@showView.render().el)
    else @resourceNotFound()

  edit: (id) ->
    packaging = @packagings.get(id)

    if packaging?
      packaging.setAllValues()

      @editView = new CertOrbe.Views.Packagings.EditView(model: packaging)
      $("#packagings").html(@editView.render().el)
    else @resourceNotFound()
