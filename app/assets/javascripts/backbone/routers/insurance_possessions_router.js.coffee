class CertOrbe.Routers.InsurancePossessionsRouter extends CertOrbe.Routers.BaseRouter
  initialize: (options) ->
    @insurancePossessions = new CertOrbe.Collections.InsurancePossessionsCollection()
    @insurancePossessions.reset options.insurancePossessions

  routes:
    "/new"      : "newInsurancePossession"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newInsurancePossession: ->
    @newInsurancePossessionView = new CertOrbe.Views.InsurancePossessions.NewView(collection: @insurancePossessions)
    $("#insurance_possessions").html(@newInsurancePossessionView.render().el)

  index: ->
    @indexView = new CertOrbe.Views.InsurancePossessions.IndexView(insurancePossessions: @insurancePossessions)
    $("#insurance_possessions").html(@indexView.render().el)

  show: (id) ->
    insurance_possession = @insurancePossessions.get(id)

    if insurance_possession?
      insurance_possession.setAllValues()

      @showView = new CertOrbe.Views.InsurancePossessions.ShowView(model: insurance_possession)
      $("#insurance_possessions").html(@showView.render().el)
    else @resourceNotFound()

  edit: (id) ->
    insurance_possession = @insurancePossessions.get(id)

    if insurance_possession?
      insurance_possession.setAllValues()

      @editView = new CertOrbe.Views.InsurancePossessions.EditView(model: insurance_possession)
      $("#insurance_possessions").html(@editView.render().el)
    else @resourceNotFound()
