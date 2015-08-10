class CertOrbe.Routers.InsurancesRouter extends CertOrbe.Routers.BaseRouter
  initialize: (options) ->
    @insurances = new CertOrbe.Collections.InsurancesCollection()
    @insurances.reset options.insurances

  routes:
    "/new"      : "newInsurance"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newInsurance: ->
    @newInsuranceView = new CertOrbe.Views.Insurances.NewView(collection: @insurances)
    $("#insurances").html(@newInsuranceView.render().el)

  index: ->
    @indexView = new CertOrbe.Views.Insurances.IndexView(insurances: @insurances)
    $("#insurances").html(@indexView.render().el)

  show: (id) ->
    insurance = @insurances.get(id)

    if insurance?
      insurance.setAllValues()

      @showView = new CertOrbe.Views.Insurances.ShowView(model: insurance)
      $("#insurances").html(@showView.render().el)
    else @resourceNotFound()

  edit: (id) ->
    insurance = @insurances.get(id)

    if insurance?
      insurance.setAllValues()

      @editView = new CertOrbe.Views.Insurances.EditView(model: insurance)
      $("#insurances").html(@editView.render().el)
      @editView.fillSelects()

    else @resourceNotFound()
