class CertOrbe.Routers.CountriesRouter extends CertOrbe.Routers.BaseRouter
  initialize: (options) ->
    @countries = new CertOrbe.Collections.CountriesCollection()
    @countries.reset options.countries

  routes:
    "/new"      : "newCountry"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newCountry: ->
    @newCountryView = new CertOrbe.Views.Countries.NewView(collection: @countries)
    $("#countries").html(@newCountryView.render().el)

  index: ->
    @indexView = new CertOrbe.Views.Countries.IndexView(countries: @countries)
    $("#countries").html(@indexView.render().el)

  show: (id) ->
    country = @countries.get(id)

    if country?
      country.setAllValues()

      @showView = new CertOrbe.Views.Countries.ShowView(model: country)
      $("#countries").html(@showView.render().el)
    else @resourceNotFound()

  edit: (id) ->
    country = @countries.get(id)

    if country?
      country.setAllValues()

      @editView = new CertOrbe.Views.Countries.EditView(model: country)
      $("#countries").html(@editView.render().el)
    else @resourceNotFound()
