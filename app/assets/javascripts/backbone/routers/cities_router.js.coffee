class CertOrbe.Routers.CitiesRouter extends CertOrbe.Routers.BaseRouter
  initialize: (options) ->
    @cities = new CertOrbe.Collections.CitiesCollection()
    @cities.reset options.cities

  routes:
    "/new"      : "newCity"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newCity: ->
    @newCityView = new CertOrbe.Views.Cities.NewView(collection: @cities)
    $("#cities").html(@newCityView.render().el)

  index: ->
    @indexView = new CertOrbe.Views.Cities.IndexView(cities: @cities)
    $("#cities").html(@indexView.render().el)

  show: (id) ->
    city = @cities.get(id)

    if city?
      city.setAllValues()

      @showView = new CertOrbe.Views.Cities.ShowView(model: city)
      $("#cities").html(@showView.render().el)
    else @resourceNotFound()

  edit: (id) ->
    city = @cities.get(id)

    if city?
      city.setAllValues()

      @editView = new CertOrbe.Views.Cities.EditView(model: city)
      $("#cities").html(@editView.render().el)
      @editView.fillSelects()  # Carga los selects dependientes
    else @resourceNotFound()
