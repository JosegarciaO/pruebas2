CertOrbe.Views.Countries ||= {}

class CertOrbe.Views.Countries.CountryView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesCountriesCountry").tmpl(data)

  tagName: "tr"

  events:
    _.extend( _.clone(@__super__.events),
     {}
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    return this
