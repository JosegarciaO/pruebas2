class CertOrbe.Routers.InsuranceCoveragesRouter extends CertOrbe.Routers.BaseRouter
  initialize: (options) ->
    @insuranceCoverages = new CertOrbe.Collections.InsuranceCoveragesCollection()
    @insuranceCoverages.reset options.insuranceCoverages

  routes:
    "/new"      : "newInsuranceCoverage"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newInsuranceCoverage: ->
    @newInsuranceCoverageView = new CertOrbe.Views.InsuranceCoverages.NewView(collection: @insuranceCoverages)
    $("#insurance_coverages").html(@newInsuranceCoverageView.render().el)

  index: ->
    @indexView = new CertOrbe.Views.InsuranceCoverages.IndexView(insuranceCoverages: @insuranceCoverages)
    $("#insurance_coverages").html(@indexView.render().el)

  show: (id) ->
    insurance_coverage = @insuranceCoverages.get(id)

    if insurance_coverage?
      insurance_coverage.setAllValues()

      @showView = new CertOrbe.Views.InsuranceCoverages.ShowView(model: insurance_coverage)
      $("#insurance_coverages").html(@showView.render().el)
    else @resourceNotFound()

  edit: (id) ->
    insurance_coverage = @insuranceCoverages.get(id)

    if insurance_coverage?
      insurance_coverage.setAllValues()

      @editView = new CertOrbe.Views.InsuranceCoverages.EditView(model: insurance_coverage)
      $("#insurance_coverages").html(@editView.render().el)
    else @resourceNotFound()
