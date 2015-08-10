CertOrbe.Views.Cities ||= {}

class CertOrbe.Views.Cities.IndexView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesCitiesIndex").tmpl(data)

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.cities.bind('reset', @addAll)

  events:
    _.extend _.clone(@__super__.events),
      "click #refresh_cities" : "refreshCities"
      "change #search_text" : "searchText"

  refreshCities: (e) ->
    e.preventDefault()
    this.filterCities()

  addAll: () ->
    @$("#cities_table tbody").empty()
    @renderPagination(@options.cities)
    @options.cities.each(@addOne)

  addOne: (city) ->
    view = new CertOrbe.Views.Cities.CityView({model : city})
    @$("#cities_table tbody").append(view.render().el)

  render: ->
    template = @template(cities: @options.cities.toJSON(true, true) )
    $(@el).html template
    @addAll()

    return this

  remove: ->
    @options.cities.unbind('reset', @addAll)
    super()

  pagination: (e) ->
    super(e, @options.cities)

  searchText: (e) ->
    e.preventDefault()
    this.filterCities()

  filterCities: () ->
    search = $("#search_text").val()  || ''
    @options.cities.fetch({ data:{search:search} })
