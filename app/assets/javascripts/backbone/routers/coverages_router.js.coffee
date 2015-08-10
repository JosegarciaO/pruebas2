class CertOrbe.Routers.CoveragesRouter extends CertOrbe.Routers.BaseRouter
  initialize: (options) ->
    @coverages = new CertOrbe.Collections.CoveragesCollection()
    @coverages.reset options.coverages

  routes:
    "/new"      : "newCoverage"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newCoverage: ->
    @newCoverageView = new CertOrbe.Views.Coverages.NewView(collection: @coverages)
    $("#coverages").html(@newCoverageView.render().el)

  index: ->
    @indexView = new CertOrbe.Views.Coverages.IndexView(coverages: @coverages)
    $("#coverages").html(@indexView.render().el)

  show: (id) ->
    coverage = @coverages.get(id)

    if coverage?
      coverage.setAllValues()

      @showView = new CertOrbe.Views.Coverages.ShowView(model: coverage)
      $("#coverages").html(@showView.render().el)
    else @resourceNotFound()

  edit: (id) ->
    coverage = @coverages.get(id)

    if coverage?
      coverage.setAllValues()

      @editView = new CertOrbe.Views.Coverages.EditView(model: coverage)
      $("#coverages").html(@editView.render().el)
    else @resourceNotFound()
