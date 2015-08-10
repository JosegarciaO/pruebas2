CertOrbe.Views.Countries ||= {}

class CertOrbe.Views.Countries.IndexView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesCountriesIndex").tmpl(data)

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.countries.bind('reset', @addAll)

  events:
    _.extend _.clone(@__super__.events),
      "click #refresh_countries" : "refreshCountries"

  refreshCountries: (e) ->
    e.preventDefault()
    @options.countries.fetch()

  addAll: () ->
    @$("#countries_table tbody").empty()
    @renderPagination(@options.countries)
    @options.countries.each(@addOne)

  addOne: (country) ->
    view = new CertOrbe.Views.Countries.CountryView({model : country})
    @$("#countries_table tbody").append(view.render().el)

  render: ->
    template = @template(countries: @options.countries.toJSON(true, true) )
    $(@el).html template
    @addAll()

    return this

  remove: ->
    @options.countries.unbind('reset', @addAll)
    super()

  pagination: (e) ->
    super(e, @options.countries)
