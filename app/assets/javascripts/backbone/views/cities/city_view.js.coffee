CertOrbe.Views.Cities ||= {}

class CertOrbe.Views.Cities.CityView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesCitiesCity").tmpl(data)

  tagName: "tr"

  events:
    _.extend( _.clone(@__super__.events),
     {}
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    return this
