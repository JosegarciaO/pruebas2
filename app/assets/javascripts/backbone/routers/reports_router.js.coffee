class CertOrbe.Routers.ReportsRouter extends CertOrbe.Routers.BaseRouter
  initialize: (options) ->
    # ---

  routes:
    "/index"    : "index"
    ".*"        : "index"

  index: ->
    @indexView = new CertOrbe.Views.Reports.IndexView()
    $("#reports").html(@indexView.render().el)
